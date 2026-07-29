//
//  Descriptography.swift
//  PadNote
//
//  Created by Paulo Eduardo Barbosa da Silva on 22/07/26.
//

import SwiftUI

struct DescriptographyScreen: View {
    @State var message: String = ""
    @Environment(NoteManager.self) private var notaManager
    @State var chaveDescriptografar1: String = ""
    var body: some View {
            VStack(spacing: 50){
                TextField("Insira a sua chave de criptografia", text: $chaveDescriptografar1)
                .frame(width: 300,height: 200)
                .cornerRadius(20)
                .padding()
                .lineLimit(5...5)
                .foregroundColor(.black)
                .background(RoundedRectangle(cornerRadius: 8).foregroundStyle(.criptographyTextField))
                    
                    
                Button(action: {
                    if let notaCriptografada = notaManager.notes.first(where: { $0.estaCriptografado }) {
                        notaManager.decryptNote(
                            note: notaCriptografada,
                            chaveDescriptografar: chaveDescriptografar1
                        )
                        
                    }
                }) {
                    Text("Descriptografar")
                }.padding()
                    .bold()
                    .background(.buttonColors)
                    .foregroundStyle(Color.white)
                    .cornerRadius(20)
            }.navigationTitle("Descriptografar")
            .navigationBarTitleDisplayMode(.inline)
        
    }
}

#Preview {
    NavigationStack{
        DescriptographyScreen()
            .environment(NoteManager())
    }
}
