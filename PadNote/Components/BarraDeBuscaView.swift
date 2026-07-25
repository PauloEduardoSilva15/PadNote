//
//  BarraDeBuscaView.swift
//  PadNote
//
//  Created by Lucas on 21/07/26.
//

import SwiftUI

public struct BarraDeBuscaView: View {
    @State var textoBusca: String = ""
    public var body: some View {
        HStack{
            HStack{
                Image(systemName: "magnifyingglass")
                    .font(Font.system(size: 22))
                TextField("Buscar", text: $textoBusca)
                Spacer()
            }
            .padding()
            .frame(width: 268, height: 47)
            .glassEffect(.regular, in: .rect(cornerRadius: 24))
            
            Button(action: {
                print("Adicionar nota")
            }){
                Image(systemName: "square.and.pencil")
                    .fontWeight(.bold)
                    .font(Font.system(size: 22))
                
            }
            .padding()
            .glassEffect(in: .circle)
        }
    }
}

#Preview {
        BarraDeBuscaView()
}
