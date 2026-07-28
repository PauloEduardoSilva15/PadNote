//
//  TelaInicialView.swift
//  PadNote
//
//  Created by Lucas on 21/07/26.
//

import SwiftUI

struct TelaInicialView: View {
    @State private var noteManager = NoteManager()
    @State private var folderManager = FolderManager()
    @State private var searchText: String = ""
    @State private var menuAcionado: Bool = false
    @State private var refreshID = UUID()
    @State private var mostrarAlertaTitulo: Bool = false
    @State private var tituloNovaNota: String = ""
    
    let colunas = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var displayedNotes: [Note] {
        let _ = noteManager.notes.count
        let _ = folderManager.currentFolder?.id
        
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
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                VStack(spacing: 10) {
                    BarraSuperiorView(menuIniciado: $menuAcionado)
                    
                    ScrollView {
                        LazyVGrid(columns: colunas, spacing: 20) {
                            ForEach(displayedNotes, id: \.id) { note in
                                Cards(
                                    note: note,
                                    isSelected: Binding(
                                        get: { noteManager.selectedNoteIds.contains(note.id) },
                                        set: { newValue in
                                            if newValue {
                                                noteManager.selectedNoteIds.insert(note.id)
                                            } else {
                                                noteManager.selectedNoteIds.remove(note.id)
                                            }
                                        }
                                    ),
                                    onTap: {
                                        if noteManager.hasSelection {
                                            noteManager.toggleSelection(note)
                                        } else {
                                            noteManager.currentNote = note
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
                        onMove: {},
                        onEncrypt: {},
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
            .navigationDestination(isPresented: .constant(noteManager.currentNote != nil)) {
                if let note = noteManager.currentNote {
                    NoteScreen(note: note, noteManager: noteManager)
                }
            }
            .onChange(of: noteManager.notes.count) { _, _ in
                refreshID = UUID()
            }
            // Alerta para escolher o título
            .alert("Título da Nota", isPresented: $mostrarAlertaTitulo) {
                TextField("Digite o título", text: $tituloNovaNota)
                    .autocapitalization(.words)
                
                Button("Cancelar", role: .cancel) {
                    tituloNovaNota = ""
                }
                
                Button("Criar") {
                    let titulo = tituloNovaNota.trimmingCharacters(in: .whitespacesAndNewlines)
                    if titulo.isEmpty {
                        noteManager.createNote(
                            title: "Nova Nota",
                            folderId: folderManager.currentFolder?.id
                        )
                    } else {
                        noteManager.createNote(
                            title: titulo,
                            folderId: folderManager.currentFolder?.id
                        )
                    }
                    refreshID = UUID()
                    tituloNovaNota = ""
                }
            } message: {
                Text("Digite o título da sua nova nota")
            }
        }
        .environment(noteManager)
        .environment(folderManager)
    }
}

#Preview {
    TelaInicialView()
}
