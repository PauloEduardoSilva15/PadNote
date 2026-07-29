//
//  Note.swift
//  PadNote
//
//  Created by Paulo Eduardo Barbosa da Silva on 25/07/26.
//
import SwiftUI
import Observation

@Observable
class NoteManager {

    var notes: [Note] = []
    var currentNote: Note?
    var selectedNoteIds: Set<UUID> = []
    var criptografia = CriptografiaModel()
    var navigationPath = NavigationPath()

    
    init() {
        // Adiciona algumas notas de exemplo
        notes = [
            Note(title: "Bem-vindo", content: "Esta é sua primeira nota!"),
            Note(title: "Lista de Compras", content: "• Maçãs\n• Pão\n• Leite"),
            Note(title: "Ideias", content: "Escreva suas ideias aqui...")
        ]
    }

    func createNote(title: String = "Nova Nota", content: String = "") {
        let newNote = Note(title: title, content: content)
        notes.insert(newNote, at: 0) // Adiciona no topo
        currentNote = newNote
    }
    
    func deleteNote(_ note: Note) {
        if let index = notes.firstIndex(where: { $0.id == note.id }) {
            notes.remove(at: index)
            if currentNote?.id == note.id {
                currentNote = notes.first
            }
        }
    }
    
    func deleteNotes(_ notesToDelete: [Note]) {
        let idsToDelete = Set(notesToDelete.map { $0.id })
        notes.removeAll { idsToDelete.contains($0.id) }
        selectedNoteIds.removeAll()
        
        if let current = currentNote, idsToDelete.contains(current.id) {
            currentNote = notes.first
        }
    }
    
    func updateNote(_ note: Note, title: String? = nil, content: String? = nil) {
        if let index = notes.firstIndex(where: { $0.id == note.id }) {
            if let newTitle = title {
                notes[index].title = newTitle
            }
            if let newContent = content {
                notes[index].content = newContent
            }
        }
    }
    
    func encryptNote(_ note: Note)  -> String {
        var retornoCriptografia = criptografia.criptografar(texto: note.content)
        note.content = retornoCriptografia!.mensagem ?? "erro"
        note.estaCriptografado = true
        return retornoCriptografia!.chave ?? "erro"

    }
    
        
    func decryptNote(note: Note, chaveDescriptografar: String) {
        var mensagemOriginal = criptografia.descriptografar(mensagemCriptografada: note.content, chave: chaveDescriptografar)
        note.estaCriptografado = false
        note.content = mensagemOriginal
    }
    
    func toggleSelection(_ note: Note) {
        if selectedNoteIds.contains(note.id) {
            selectedNoteIds.remove(note.id)
        } else {
            selectedNoteIds.insert(note.id)
        }
    }
    
    func clearSelection() {
        selectedNoteIds.removeAll()
    }
    
    var selectedNotes: [Note] {
        notes.filter { selectedNoteIds.contains($0.id) }
    }
    
    var hasSelection: Bool {
        !selectedNoteIds.isEmpty
    }
    func irParaTelaInicial() {
        navigationPath = NavigationPath() 
    }
}


@Observable
class Note: Identifiable, Equatable {
    let id: UUID
    var title: String
    var content: String
    var createdAt: Date
    var updatedAt: Date
    var estaCriptografado: Bool = false
    
    init(id: UUID = UUID(), title: String = "", content: String = "") {
        self.id = id
        self.title = title
        self.content = content
        self.createdAt = Date()
        self.updatedAt = Date()
    }
    
    static func == (lhs: Note, rhs: Note) -> Bool {
        lhs.id == rhs.id
    }
}
