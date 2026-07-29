//
//  telaDecidirCriptografia.swift
//  PadNote
//
//  Created by Lucas on 27/07/26.
//

import SwiftUI

struct CriptografiaView: View {
    // Cor principal baseada no azul da imagem
    let primaryBlue = Color(red: 0.28, green: 0.38, blue: 0.96)
    
    var body: some View {
        VStack(spacing: 20) {
            
            // Cabeçalho
            HStack {
                Button(action: {
                    // Ação de voltar aqui
                }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.black)
                        .frame(width: 44, height: 44)
                        .background(
                            Circle()
                                .fill(Color.white)
                                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                        )
                }
                
                Spacer()
                
                Text("Criptografia")
                    .font(.system(size: 20, weight: .regular))
                    .foregroundColor(.black)
                    // Adicionando um padding negativo compensatório para centralizar o texto
                    // em relação à tela, não em relação ao espaço que sobra.
                    .padding(.trailing, 44)
                
                Spacer()
            }
            .padding(.horizontal, 24)
            .padding(.top, 20)
            
            Spacer()
                .frame(height: 80)
            
            // Texto descritivo
            Text("Escolha como deseja criptografar seus dados. Se for sua primeira vez criptografe e gere uma nova chave.")
                .font(.system(size: 17, weight: .regular))
                .foregroundColor(Color.black.opacity(0.8))
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 32)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
                .frame(height: 60)
            
            // Área de Botões
            VStack(spacing: 16) {
                
                // Botão Primário
                Button(action: {
                    // Ação Criptografar
                }) {
                    Text("Criptografar e gerar chave")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 18)
                        .background(primaryBlue)
                        .clipShape(Capsule())
                }
                
                // Botão Secundário
                Button(action: {
                    // Ação Já possuo chave
                }) {
                    Text("Já possuo uma chave")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(primaryBlue)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 18)
                        .background(primaryBlue.opacity(0.15))
                        .clipShape(Capsule())
                }
                
                // Botão em formato de Link
                Button(action: {
                    // Ação Dúvida
                }) {
                    Text("Como criptografar meus dados?")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(primaryBlue)
                }
                .padding(.top, 10)
            }
            .padding(.horizontal, 32)
            
            Spacer()
        }
        // Fundo cinza bem claro, parecido com o da imagem
        .background(Color(red: 0.96, green: 0.96, blue: 0.97).edgesIgnoringSafeArea(.all))
    }
}

struct CriptografiaView_Previews: PreviewProvider {
    static var previews: some View {
        CriptografiaView()
    }
}
