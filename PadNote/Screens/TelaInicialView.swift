//
//  TelaInicialView.swift
//  PadNote
//
//  Created by Lucas on 21/07/26.
//

import SwiftUI

enum RotaNavegacao: Hashable {
    case telaCriptografia1
    case telaCriptografadoComChave(chave: String)
    case descriptografar
    case detalheNota(id: UUID)
    case confirmacaoCriptografia
}

struct TelaInicialView: View {
    @State private var noteManager = NoteManager()
    @State private var folderManager = FolderManager()
    @State private var searchText: String = ""
    @State private var menuAcionado: Bool = false
    @State private var refreshID = UUID()
    @State private var mostrarAlertaTitulo: Bool = false
    @State private var tituloNovaNota: String = ""
    
    @State private var path = NavigationPath()
    
    let colunas = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var displayedNotes: [Note] {
        let allNotes = noteManager.notes
        let currentFolder = folderManager.currentFolder
        
        let filteredNotes: [Note]
        if let currentFolder = currentFolder {
            if currentFolder.isDefault {
                filteredNotes = allNotes
            } else {
                filteredNotes = allNotes.filter { $0.folderId == currentFolder.id }
            }
        } else {
            filteredNotes = allNotes
        }
        
        if searchText.isEmpty {
            return filteredNotes
        } else {
            return filteredNotes.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.content.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    private func bindingParaNota(_ note: Note) -> Binding<Bool> {
        Binding(
            get: { noteManager.selectedNoteIds.contains(note.id) },
            set: { isSelected in
                if isSelected {
                    noteManager.selectedNoteIds.insert(note.id)
                } else {
                    noteManager.selectedNoteIds.remove(note.id)
                }
            }
        )
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack(alignment: .bottom) {
                VStack(spacing: 10) {
                    BarraSuperiorView(menuIniciado: $menuAcionado)
                    
                    ScrollView {
                        LazyVGrid(columns: colunas, spacing: 20) {
                            ForEach(displayedNotes, id: \.id) { note in
                                Cards(
                                    note: note,
                                    isSelected: bindingParaNota(note),
                                    onTap: {
                                        if noteManager.hasSelection {
                                            noteManager.toggleSelection(note)
                                        } else {
                                            if note.estaCriptografado {
                                                path.append(RotaNavegacao.descriptografar)
                                            } else {
                                                noteManager.currentNote = note
                                                path.append(RotaNavegacao.detalheNota(id: note.id))
                                            }
                                        }
                                    },
                                    onLongPress: {
                                        if !noteManager.hasSelection {
                                            noteManager.toggleSelection(note)
                                        }
                                    }
                                )
                                .id(note.id)
                            }
                        }
                        .padding()
                        .id(refreshID)
                    }
                }
                .overlay {
                    if menuAcionado {
                        Color.black.opacity(0.4)
                            .ignoresSafeArea()
                            .onTapGesture {
                                menuAcionado.toggle()
                            }
                    }
                }
                
                if noteManager.hasSelection {
                    BarraInferiorView(
                        onDelete: {
                            noteManager.deleteNotes(noteManager.selectedNotes)
                            refreshID = UUID()
                        },
                        onShare: {}
                    )
                    .id(refreshID)
                } else {
                    BarraDeBuscaView(
                        searchText: $searchText,
                        onCreateNote: {
                            tituloNovaNota = ""
                            mostrarAlertaTitulo = true
                        }
                    )
                }
                
                if menuAcionado {
                    BarraDePastasView(menuIniciado: $menuAcionado)
                }
            }
            .navigationDestination(for: RotaNavegacao.self) { rota in
                switch rota {
                case .telaCriptografia1:
                    TelaCriptografia1()
                case .telaCriptografadoComChave(let chave):
                    TelaCriptografadoComChaveView(chave: chave)
                case .descriptografar:
                    DescriptographyScreen()
                case .detalheNota(let id):
                    if let note = noteManager.notes.first(where: { $0.id == id }) {
                        NoteScreen(note: note, noteManager: noteManager)
                    }
                case .confirmacaoCriptografia:
                        ConfirmCriptographyScreen()
                }
            } 
            .onChange(of: noteManager.notes.count) { _, _ in
                refreshID = UUID()
            }
            .alert("Título da Nota", isPresented: $mostrarAlertaTitulo) {
                TextField("Digite o título", text: $tituloNovaNota)
                    .autocapitalization(.words)
                
                Button("Cancelar", role: .cancel) {
                    tituloNovaNota = ""
                }
                
                Button("Criar") {
                    let titulo = tituloNovaNota.trimmingCharacters(in: .whitespacesAndNewlines)
                    noteManager.createNote(
                        title: titulo.isEmpty ? "Nova Nota" : titulo,
                        folderId: folderManager.currentFolder?.id
                    )
                    refreshID = UUID()
                    tituloNovaNota = ""
                }
            } message: {
                Text("Digite o título da sua nova nota")
            }
        }
        .environment(\.navigationPath, $path)
        .environment(noteManager)
        .environment(folderManager)
    } 
}

private struct NavigationPathKey: EnvironmentKey {
    static let defaultValue: Binding<NavigationPath> = .constant(NavigationPath())
}

extension EnvironmentValues {
    var navigationPath: Binding<NavigationPath> {
        get { self[NavigationPathKey.self] }
        set { self[NavigationPathKey.self] = newValue }
    }
}

#Preview {
    TelaInicialView()
}
