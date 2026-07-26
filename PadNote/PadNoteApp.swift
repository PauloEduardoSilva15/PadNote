//
//  PadNoteApp.swift
//  PadNote
//
//  Created by Paulo Eduardo Barbosa da Silva on 17/07/26.
//

import SwiftUI

@main
struct PadNoteApp: App {
    @State private var noteManager = NoteManager()
    
    var body: some Scene {
        WindowGroup {
            TelaInicialView()
                .environment(noteManager)
        }
    }
}
