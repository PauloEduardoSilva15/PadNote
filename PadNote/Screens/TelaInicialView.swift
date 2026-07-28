//
//  Teste1.swift
//  PadNote
//
//  Created by Lucas on 21/07/26.
//


import SwiftUI

struct TelaInicialView: View {
    @State private var noteManager = NoteManager()
    @State private var searchText: String = ""
    @State private var menuAcionado: Bool = false
    @State private var pastas: Set<String> = ["Todas as Notas"]
    
    let colunas = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var filteredNotes: [Note] {
        if searchText.isEmpty {
            return noteManager.notes
        } else {
            return noteManager.notes.filter {
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
                            ForEach(filteredNotes) { note in
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
                                            // Navegar para a nota
                                            noteManager.currentNote = note
                                        }
                                    },
                                    onLongPress: {
                                        if !noteManager.hasSelection {
                                            noteManager.toggleSelection(note)
                                        }
                                    }
                                )
                                .onTapGesture {
                                    // O tap já é tratado dentro do Cards
                                }
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
                            // Implementar mover
                        },
                        onEncrypt: {
                            // Implementar criptografia
                        },
                        onShare: {
                            // Implementar compartilhamento
                        },
                        pastas: $pastas,
                    )
                } else {
                    BarraDeBuscaView(
                        searchText: $searchText,
                        onCreateNote: {
                            noteManager.createNote()
                        }
                    )
                }
                
                if menuAcionado {
                    BarraDePastasView(
                        menuIniciado: $menuAcionado,
                        pastas: $pastas
                    )
                }
            }
            .navigationDestination(isPresented: .constant(noteManager.currentNote != nil)) {
                if let note = noteManager.currentNote {
                    NoteScreen(note: note, noteManager: noteManager)
                }
            }
        }
        .environment(noteManager)
    }
}

#Preview {
    TelaInicialView()
}
