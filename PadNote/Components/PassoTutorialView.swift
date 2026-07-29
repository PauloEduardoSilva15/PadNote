//
//  PassoTutorialView.swift
//  PadNote
//
//  Created by Lucas on 29/07/26.
//

import SwiftUI

struct PassoTutorialView: View {
    let icone: String
    let titulo: String
    let descricao: String
    var corIcone: Color = Color(red: 0.28, green: 0.38, blue: 0.96)
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Image(systemName: icone)
                .font(.system(size: 28))
                .foregroundColor(corIcone)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(titulo)
                    .font(.headline)
                    .foregroundColor(.black)
                
                Text(descricao)
                    .font(.subheadline)
                    .foregroundColor(.black.opacity(0.7))
                    .fixedSize(horizontal: false, vertical: true) 
            }
        }
    }
}

#Preview {
    PassoTutorialView(
        icone: "1.circle.fill",
        titulo: "Passo de Exemplo",
        descricao: "teste"
    )
}
