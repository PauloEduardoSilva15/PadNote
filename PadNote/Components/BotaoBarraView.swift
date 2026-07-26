//
//  BotaoBarraView.swift
//  PadNote
//
//  Created by Lucas on 25/07/26.
//
import SwiftUI

struct BotaoBarraView: View {
    let titulo: String
    let icone: String
    var isDestructive: Bool = false
    let acao: () -> Void
    
    var body: some View {
        Button(action: acao) {
            VStack(spacing: 4) {
                Image(systemName: icone)
                    .font(.system(size: 18))
                
                Text(titulo)
                    .font(.caption2)
            }
            .foregroundColor(isDestructive ? .red : .blue)
        }
    }
}

#Preview {
    ZStack {
        // Fundo para testar o efeito de transparência/vidro
        LinearGradient(colors: [.blue, .purple], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
        
        VStack {
            Spacer()
            //BarraInferiorView()
                .padding(.horizontal)
        }
    }
}
