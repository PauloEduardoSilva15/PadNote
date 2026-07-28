//
//  Teste1.swift
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
    
    let colunas = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var displayedNotes: [Note] {
        // Pega as notas da pasta atual ou todas as notas
        let notes: [Note]
        if let currentFolder = folderManager.currentFolder {
            notes = folderManager.getNotes(for: currentFolder, from: noteManager)
        } else {
            notes = noteManager.notes
        }
        
        // Aplica o filtro de busca
        if searchText.isEmpty {
            return notes
        } else {
            return notes.filter {
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
                            ForEach(displayedNotes) { note in
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
                            }
                        }
                        .padding()
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
                        },
                        onMove: {
                            // Mostrar sheet para mover notas entre pastas
                            // Implementação futura
                        },
                        onEncrypt: {
                            // Implementar criptografia
                        },
                        onShare: {
                            // Implementar compartilhamento
                        }
                    )
                } else {
                    BarraDeBuscaView(
                        searchText: $searchText,
                        onCreateNote: {
                            // Cria nota na pasta atual (se houver)
                            noteManager.createNote(folderId: folderManager.currentFolder?.id)
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
        }
        .environment(noteManager)
        .environment(folderManager)
    }
}

#Preview {
    TelaInicialView()
}
