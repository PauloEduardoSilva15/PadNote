//
//  Teste1.swift
//  PadNote
//
//  Created by Lucas on 21/07/26.
//

import SwiftUI

struct TelaInicialView: View {
    @State var searchText: String = ""
    
    let colunas = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack(alignment: .bottom){
            VStack(spacing: 15) {
                BarraSuperiorView()
                
                ScrollView {
                    LazyVGrid(columns: colunas, spacing: 10) {
                        ForEach(0..<100) { _ in
                            Cards()
                        }
                    }
                    .padding()
                    .padding(.bottom, 60)
                }
            }
            BarraDeBuscaView()
                .padding(.bottom, 16)
        }
    }
}


#Preview {
    TelaInicialView()
}
