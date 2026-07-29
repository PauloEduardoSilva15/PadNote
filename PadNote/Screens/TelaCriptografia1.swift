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
    @State private var mostrarErroCriptografia: Bool = false
    @State private var mensagemErro: String = ""
    @State private var mostrarSheetChaveExistente: Bool = false
    @State private var chaveExistenteInserida: String = ""
    
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
                            if let chave = notaManager.encryptNote(nota) {
                                chaveCriptografia = chave
                                path.wrappedValue.append(RotaNavegacao.telaCriptografadoComChave(chave: chaveCriptografia))
                            } else {
                                mensagemErro = "Não foi possível criptografar a nota. Tente novamente."
                                mostrarErroCriptografia = true
                            }
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
                        chaveExistenteInserida = ""
                        mostrarSheetChaveExistente = true
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
        .alert("Erro", isPresented: $mostrarErroCriptografia) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(mensagemErro)
        }
        .sheet(isPresented: $mostrarSheetChaveExistente) {
            VStack(spacing: 24) {
                Text("Usar chave existente")
                    .font(.headline)
                    .foregroundColor(.black)
                
                Text("Cole a chave que você já possui para criptografar essa nota com ela.")
                    .font(.subheadline)
                    .foregroundColor(Color.black.opacity(0.7))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                TextField("Cole sua chave aqui", text: $chaveExistenteInserida)
                    .padding()
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(12)
                    .padding(.horizontal)
                
                HStack(spacing: 16) {
                    Button(action: {
                        mostrarSheetChaveExistente = false
                    }) {
                        Text("Cancelar")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color.red.opacity(0.1))
                            .cornerRadius(12)
                    }
                    
                    Button(action:{
                        if let nota = notaManager.selectedNotes.first {
                            let sucesso = notaManager.encryptNoteComChaveExistente(nota, chave: chaveExistenteInserida)
                            
                            if sucesso {
                                mostrarSheetChaveExistente = false
                                
                                path.wrappedValue.append(RotaNavegacao.confirmacaoCriptografia)
                                
                            } else {
                                mensagemErro = "Chave inválida. Verifique e tente novamente."
                                mostrarErroCriptografia = true
                            }
                        }
                    }
                    ) {
                        Text("Criptografar")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(corBotao)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(corBotao.opacity(0.1))
                            .cornerRadius(12)

                    }                }
                .padding(.horizontal)
            }
            .padding(.top, 32)
            .presentationDetents([.fraction(0.4), .medium])
            .presentationDragIndicator(.visible)
        }
    }
}

#Preview {
    TelaCriptografia1(chaveCriptografia: "")
        .environment(NoteManager())
        .environment(\.navigationPath, .constant(NavigationPath()))
}
