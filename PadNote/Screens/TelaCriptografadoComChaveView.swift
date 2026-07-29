//
//  TelaCriptografadoComChaveView.swift
//  PadNote
//
//  Created by Lucas on 28/07/26.
//

import SwiftUI

struct TelaCriptografadoComChaveView: View {
    @State var chave: String
    @State var criptografado: Bool = false
    var body: some View {
        VStack(spacing: 50){
                CriptografiedMensager()
            VStack(spacing: 20){
                Text(chave)
                    .frame(width: 350, height: 150)
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 0)
                
                Button("Copiar"){
                    UIPasteboard.general.string = chave
                }
                .padding()
                .background(.buttonColors.opacity(0.1))
                .foregroundStyle(Color.blue)
                .bold()
                .cornerRadius(20)
            }
                Button("Concluir"){
                    criptografado = true
                }
                .padding()
                .frame(width: 250, height: 50)
                .background(.buttonColors)
                .foregroundStyle(Color.white)
                .bold()
                .cornerRadius(40)
            
            
            
            
        }.navigationTitle("Criptografado")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(isPresented: $criptografado){
                TelaInicialView()
            }
        
        
    }
}

#Preview {
        TelaCriptografadoComChaveView(chave: "")
    
}
