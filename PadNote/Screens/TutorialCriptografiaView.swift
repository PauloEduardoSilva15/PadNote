//
//  TutorialCriptografiaView.swift
//  PadNote
//
//  Created by Lucas on 29/07/26.
//

import SwiftUI

struct TutorialCriptografiaView: View {
    @Environment(\.dismiss) private var dismiss
    
    let corPrincipal = Color(red: 0.28, green: 0.38, blue: 0.96)
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                VStack(spacing: 16) {
                    Image(systemName: "lock.shield.fill")
                        .font(.system(size: 64))
                        .foregroundColor(corPrincipal)
                        .padding(.top, 40)
                    
                    Text("Como funciona a proteção")
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                }
                
                VStack(alignment: .leading, spacing: 24) {
                    
                    PassoTutorialView(
                        icone: "1.circle.fill",
                        titulo: "Escolha ou crie uma nota",
                        descricao: "Na tela inicial, selecione qual nota você deseja criptografar."
                    )
                    
                    PassoTutorialView(
                        icone: "2.circle.fill",
                        titulo: "Gere ou use uma chave",
                        descricao: "Gere uma chave automática de 256 bits ou cole uma chave em formato Base64 que você já possui."
                    )
                    
                    PassoTutorialView(
                        icone: "exclamationmark.triangle.fill",
                        titulo: "Guarde sua chave!",
                        descricao: "Por ser simétrica, se você perder a chave, os dados serão perdidos permanentemente, pois ela não fica salva nos servidores.",
                        corIcone: .orange
                    )
                    
                    PassoTutorialView(
                        icone: "key.fill",
                        titulo: "Criptografia Simétrica",
                        descricao: "O app utiliza a mesma chave única para trancar e destrancar seus dados. Sem essa chave exata, a leitura é impossível."
                    )
                    
                    PassoTutorialView(
                        icone: "shield.checkered",
                        titulo: "Padrão AES-GCM (256 bits)",
                        descricao: "Utilizamos o algoritmo de alto nível AES-GCM. Ele oculta suas informações e garante que elas não foram alteradas."
                    )
                }
                .padding(.horizontal, 24)
                
                Spacer()
                
                Button(action: {
                    dismiss()
                }) {
                    Text("Entendi")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 18)
                        .background(corPrincipal)
                        .clipShape(Capsule())
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 20)
            }
        }
        .background(Color(red: 0.96, green: 0.96, blue: 0.97).ignoresSafeArea())
    }
}

#Preview {
    TutorialCriptografiaView()
}
