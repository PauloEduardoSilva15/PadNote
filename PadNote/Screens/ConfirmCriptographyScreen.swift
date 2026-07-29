//
//  ConfirmCriptographyScreen.swift
//  PadNote
//
//  Created by Paulo Eduardo Barbosa da Silva on 22/07/26.
//

import SwiftUI

struct ConfirmCriptographyScreen: View {
    @Environment(\.navigationPath) private var path
    @Environment(NoteManager.self) private var noteManager

    
    var body: some View {
        VStack(spacing: 100){
            CriptografiedMensager()
            
            Button("Voltar a tela inicial") {
                noteManager.selectedNoteIds.removeAll()
                path.wrappedValue = NavigationPath()
            }
            .padding()
            .background(.buttonColors)
            .foregroundStyle(Color.white)
            .bold()
            .cornerRadius(20)
            
        }
        .navigationTitle("Criptografado")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    NavigationStack {
        ConfirmCriptographyScreen()
            .environment(\.navigationPath, .constant(NavigationPath()))
            .environment(NoteManager())
    }
}
