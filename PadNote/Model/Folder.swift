//
//  FolderManager.swift
//  PadNote
//
//  Created by Seu Nome on 28/07/26.
//

import SwiftUI
import Observation

@Observable
class FolderManager {
    // MARK: - Propriedades
    var folders: [Folder] = []
    var currentFolder: Folder?
    var selectedFolderId: UUID?
    
    // MARK: - Inicializador
    init() {
        // Cria a pasta padrão "Todas as Notas"
        let defaultFolder = Folder(name: "Todas as Notas", isDefault: true)
        folders.append(defaultFolder)
        currentFolder = defaultFolder
        selectedFolderId = defaultFolder.id
    }
    
    // MARK: - CRUD de Pastas
    func createFolder(name: String) {
        guard !name.isEmpty else { return }
        // Verifica se já existe uma pasta com o mesmo nome
        guard !folders.contains(where: { $0.name.lowercased() == name.lowercased() }) else {
            return
        }
        
        let newFolder = Folder(name: name)
        folders.append(newFolder)
    }
    
    func deleteFolder(_ folder: Folder) {
        // Não permite deletar a pasta padrão
        guard !folder.isDefault else { return }
        
        if let index = folders.firstIndex(where: { $0.id == folder.id }) {
            folders.remove(at: index)
            
            // Se a pasta atual for deletada, volta para a pasta padrão
            if currentFolder?.id == folder.id {
                currentFolder = folders.first(where: { $0.isDefault })
                selectedFolderId = currentFolder?.id
            }
        }
    }
    
    func renameFolder(_ folder: Folder, newName: String) {
        guard !newName.isEmpty else { return }
        guard !folder.isDefault else { return }
        guard !folders.contains(where: { $0.name.lowercased() == newName.lowercased() && $0.id != folder.id }) else {
            return
        }
        
        if let index = folders.firstIndex(where: { $0.id == folder.id }) {
            folders[index].name = newName
        }
    }
    
    func selectFolder(_ folder: Folder) {
        currentFolder = folder
        selectedFolderId = folder.id
    }
    
    func getNotes(for folder: Folder, from noteManager: NoteManager) -> [Note] {
        if folder.isDefault {
            // "Todas as Notas" mostra todas as notas
            return noteManager.notes
        } else {
            // Mostra apenas notas da pasta específica
            return noteManager.notes.filter { $0.folderId == folder.id }
        }
    }
    
    var defaultFolder: Folder? {
        folders.first(where: { $0.isDefault })
    }
    
    var customFolders: [Folder] {
        folders.filter { !$0.isDefault }
    }
}

// MARK: - Modelo Folder
@Observable
class Folder: Identifiable, Equatable {
    let id: UUID
    var name: String
    let isDefault: Bool
    var createdAt: Date
    
    init(id: UUID = UUID(), name: String, isDefault: Bool = false) {
        self.id = id
        self.name = name
        self.isDefault = isDefault
        self.createdAt = Date()
    }
    
    static func == (lhs: Folder, rhs: Folder) -> Bool {
        lhs.id == rhs.id
    }
}
