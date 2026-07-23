//
//  Teste1.swift
//  PadNote
//
//  Created by Lucas on 21/07/26.
//

import SwiftUI

struct TelaInicialView: View {
    @State var searchText: String = ""
    @State var menuAcionado: Bool = false
    @State private var pastas: Set<String> = ["Todas as Notas"]
    
    let colunas = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack(alignment: .bottom){
            VStack(spacing: 15) {
                BarraSuperiorView(menuIniciado: $menuAcionado)
                ScrollView {
                    LazyVGrid(columns: colunas, spacing: 10) {
                        ForEach(0..<100) { _ in
                            Cards()
                        }
                    }
                    .padding()
                    .padding(.bottom, 60)
                }
            }.overlay{
                if menuAcionado {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                        .onTapGesture {
                            menuAcionado.toggle() 
                        }
                }
            }
            BarraDeBuscaView()
                .padding(.bottom, 16)
            if menuAcionado {
                BarraDePastasView(menuIniciado: $menuAcionado, pastas: $pastas)
            }
        }
    }
}



#Preview {
    TelaInicialView()
}
