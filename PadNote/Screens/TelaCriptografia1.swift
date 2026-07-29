//
//  telaDecidirCriptografia.swift
//  PadNote
//
//  Created by Lucas on 27/07/26.
//

import SwiftUI

struct TelaCriptografia1: View {
    let corBotao = Color(red: 0.28, green: 0.38, blue: 0.96)
    @Environment(NoteManager.self) private var notaManager
    @Environment(\.navigationPath) private var path
    @State var chaveCriptografia: String = ""
    
    var body: some View {
        VStack(spacing: 40) {
            HStack {
                Text("Criptografia")
                    .font(.system(size: 20, weight: .regular))
                    .foregroundColor(.black)
            }
            .padding(.horizontal, 24)
            .padding(.top, 20)
            
            Spacer().frame(height: 80)
            
            VStack {
                Text("Escolha como deseja criptografar seus dados. Se for sua primeira vez criptografe e gere uma nova chave.")
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(Color.black.opacity(0.8))
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, 32)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer().frame(height: 60)
                
                VStack(spacing: 16) {
                    Button(action: {
                        if let nota = notaManager.selectedNotes.first {
                            chaveCriptografia = notaManager.encryptNote(nota)
                            // Avança para a tela final passando a chave
                            path.wrappedValue.append(RotaNavegacao.telaCriptografadoComChave(chave: chaveCriptografia))
                        }
                    }) {
                        Text("Criptografar e gerar chave")
                    }
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 18)
                    .background(corBotao)
                    .clipShape(Capsule())
                    
                    Button(action: {
                        path.wrappedValue.append(RotaNavegacao.descriptografar)
                    }) {
                        Text("Já possuo uma chave")
                            .font(.system(size: 16))
                            .foregroundColor(corBotao)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 18)
                            .background(corBotao.opacity(0.20))
                            .clipShape(Capsule())
                    }
                                        
                    Button(action: {}) {
                        Text("Como criptografar meus dados?")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(corBotao)
                    }
                    .padding(.top, 10)
                }
                .padding(.horizontal, 32)
                
                Spacer()
            }
        }
        .background(Color(red: 0.96, green: 0.96, blue: 0.97).ignoresSafeArea(.all))
    }
}

#Preview {
    TelaCriptografia1(chaveCriptografia: "")
        .environment(NoteManager())
        .environment(\.navigationPath, .constant(NavigationPath()))
}
