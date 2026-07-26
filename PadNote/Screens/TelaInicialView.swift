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
    @State var estaSelecionado: Bool = false
    @State var jaHouveSelecao: Bool = false
    @State var qtdSelecionados: Int = 0
    
    let colunas = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom){
                VStack(spacing: 15) {
                    BarraSuperiorView(menuIniciado: $menuAcionado)
                    ScrollView {
                        LazyVGrid(columns: colunas, spacing: 10) {
                            ForEach(0..<100) { _ in
                                Cards(jaHouveSelecao: $jaHouveSelecao, qtdSelecionados: $qtdSelecionados)
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
                
                if qtdSelecionados > 0 {
                    BarraInferiorView()
                }
                else{
                    BarraDeBuscaView()
                }
                
                //.padding(.bottom, 16)
                if menuAcionado {
                    BarraDePastasView(menuIniciado: $menuAcionado, pastas: $pastas)
                }
            }
            }
        }
    }



#Preview {
    TelaInicialView()
}
