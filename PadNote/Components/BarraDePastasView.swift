//
//  BarraDePastasView.swift
//  PadNote
//
//  Created by Lucas on 22/07/26.
//

import SwiftUI

struct BarraDePastasView: View {
    @Binding var menuIniciado: Bool
    @State var nomePasta: String = ""
    @State var abrirSheet = false
    @Binding var pastas: Set<String>
    var body: some View {
        ZStack(alignment: .topLeading) {
            HStack {
                Rectangle()
                    .cornerRadius(20)
                    .foregroundStyle(Color.white)
                    .ignoresSafeArea()
                    .containerRelativeFrame(.horizontal){ size, axis in
                        size * 0.66
                    }
            }
            VStack{
                HStack{
                    Button(action: {
                        menuIniciado.toggle()
                    }) {
                        Image(systemName: "chevron.backward")
                            .padding(10)
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.black)
                            .glassEffect(in: .circle)
                    }
                    Text("Suas pastas")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.black)
                        .padding(.horizontal, 10)
                    Spacer()
                }.padding()
                
                HStack{
                    VStack(alignment: .leading,spacing: 15){
                        ForEach(pastas.sorted(), id: \.self){ pasta in
                            HStack{
                                Image(systemName: "folder")
                                Text(pasta)
                            }.font(Font.system(size: 22, weight: .regular))
                        }
                        HStack{
                            Button(action: {
                                abrirSheet.toggle()
                            })
                            {
                                Image(systemName: "folder.badge.plus")
                                Text("Adicionar Pasta")
                                
                            }                            }
                        .font(Font.system(size: 22, weight: .regular))
                        .buttonStyle(.plain)
                    }
                    Spacer()
                }.padding()
            }
        }.sheet(isPresented: $abrirSheet){
            VStack(spacing: 25){
                HStack{
                    Button(action: {
                        abrirSheet.toggle()
                    })
                    {
                        Image(systemName: "multiply")
                            .font(Font.system(size: 22, weight: .bold))
                    }
                    .padding()
                    .glassEffect(in: .circle)
                    
                    Spacer()
                    Text("Adicionar pasta")
                    Spacer()
                    Button(action: {
                        pastas.insert(nomePasta)
                        nomePasta = ""
                        abrirSheet.toggle()
                    })
                    {
                        Image(systemName: "checkmark")
                            .font(Font.system(size: 22, weight: .bold))
                    }
                    .padding()
                    .glassEffect(in: .circle)
                }.padding()
                VStack{
                    TextField("Nome da pasta", text: $nomePasta)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                    
                    
                }
                .padding()
                Spacer()
            }
        }
    }
}

#Preview {
    BarraDePastasView(menuIniciado: .constant(false), pastas: .constant(["teste1", "teste2"]), )
}
