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
    var criptografia = CriptografiaModel()
    var navigationPath = NavigationPath()
    var currentNote: Note?
    var selectedNoteIds: Set<UUID> = []
    private var updateTrigger: Bool = false
    init() {
        notes = [
            Note(title: "Bem-vindo", content: "Esta é sua primeira nota!"),
            Note(title: "Lista de Compras", content: "• Maçãs\n• Pão\n• Leite"),
            Note(title: "Ideias", content: "Escreva suas ideias aqui...")
        ]
    }
    func createNote(title: String = "Nova Nota", content: String = "", folderId: UUID? = nil) {
        let newNote = Note(title: title, content: content, folderId: folderId)
        notes.insert(newNote, at: 0)
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
    
    func updateNote(_ note: Note, title: String? = nil, content: String? = nil, folderId: UUID? = nil) {
        if let index = notes.firstIndex(where: { $0.id == note.id }) {
            if let newTitle = title {
                notes[index].title = newTitle
            }
            if let newContent = content {
                notes[index].content = newContent
            }
            if let newFolderId = folderId {
                notes[index].folderId = newFolderId
            }
            notes[index].updatedAt = Date()
        }
    }
    
    func moveNotesToFolder(_ notesToMove: [Note], folderId: UUID?) {
        for note in notesToMove {
            if let index = notes.firstIndex(where: { $0.id == note.id }) {
                notes[index].folderId = folderId
                notes[index].updatedAt = Date()
              
            }
        }
        clearSelection()
    }
    
    func encryptNote(_ note: Note) -> String? {
        guard let retornoCriptografia = criptografia.criptografar(texto: note.content) else {
            return nil
        }
        note.content = retornoCriptografia.mensagem
        note.estaCriptografado = true
        return retornoCriptografia.chave
    }
    
    func encryptNoteComChaveExistente(_ note: Note, chave: String) -> Bool {
        guard let mensagemCriptografada = criptografia.criptografarComChaveExistente(texto: note.content, chaveBase64: chave) else {
            return false
        }
        note.content = mensagemCriptografada
        note.estaCriptografado = true
        return true
    }
    
    func decryptNote(note: Note, chaveDescriptografar: String) -> Bool {
        guard let mensagemOriginal = criptografia.descriptografar(mensagemCriptografada: note.content, chave: chaveDescriptografar) else {
            return false
        }
        note.estaCriptografado = false
        note.content = mensagemOriginal
        return true
    }
    
    
    func toggleSelection(_ note: Note) {
        if selectedNoteIds.contains(note.id) {
            selectedNoteIds.remove(note.id)
        } else {
            selectedNoteIds.insert(note.id)
        }
    }
    
    func clearSelection() {
        selectedNoteIds.removeAll()    }
    
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

import Foundation
import Observation

@Observable
class Note: Identifiable, Equatable, Hashable {
    let id: UUID
    var title: String
    var content: String
    var createdAt: Date
    var updatedAt: Date
    var folderId: UUID?
    var estaCriptografado: Bool = false
    
    init(id: UUID = UUID(), title: String = "", content: String = "", folderId: UUID? = nil) {
        self.id = id
        self.title = title
        self.content = content
        self.createdAt = Date()
        self.updatedAt = Date()
        self.folderId = folderId
    }
    
    static func == (lhs: Note, rhs: Note) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
