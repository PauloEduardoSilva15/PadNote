//
//  BarraInferiorView.swift
//  PadNote
//
//  Created by Lucas on 25/07/26.
//

import SwiftUI

struct BarraInferiorView: View {
    let onDelete: () -> Void
    let onMove: () -> Void
    let onEncrypt: () -> Void
    let onShare: () -> Void
    
    var body: some View {
        HStack {
            Spacer()
            
            BotaoBarraView(titulo: "Mover", icone: "arrow.forward.folder") {
                onMove()
            }
            
            Spacer()
            
            BotaoBarraView(titulo: "Criptografar", icone: "lock") {
                onEncrypt()
            }
            
            Spacer()
            
            BotaoBarraView(titulo: "Compartilhar", icone: "square.and.arrow.up") {
                onShare()
            }
            
            Spacer()
            
            BotaoBarraView(titulo: "Excluir", icone: "trash", isDestructive: true) {
                onDelete()
            }
            
            Spacer()
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .glassEffect(in: Capsule())
    }
}

#Preview {
    ZStack {
        LinearGradient(colors: [.blue, .purple], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
        
        VStack {
            Spacer()
            BarraInferiorView(
                onDelete: {},
                onMove: {},
                onEncrypt: {},
                onShare: {}
            )
            .padding(.horizontal)
        }
    }
}
