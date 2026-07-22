//
//  BarraSuperiorView.swift
//  PadNote
//
//  Created by Lucas on 21/07/26.
//

import SwiftUI

import SwiftUI

struct BarraSuperiorView: View {
    //@State private var searchText = ""

    var body: some View {
        HStack{
            //Spacer()
            //Botoes de configuracao e conta
            Button(action: {
                print("teste menu")
            }){
                Image(systemName: "folder.fill")
                    .font(Font.system(size: 22))
                
                
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 14)
            //.background(Color.white)
            .glassEffect(in: .circle)
            //.clipShape(Circle())
            .shadow(color: Color.black.opacity(0.08), radius: 10, x: 0, y: 4)
            
            
            Spacer()
            HStack(spacing: 20){
                Button(action: {
                    print("teste configuracoes")
                }){
                    Image(systemName: "gearshape")
                        .font(Font.system(size: 22))
                        .fontWeight(.bold)
                    
                    
                }
                
                Button(action: {
                    print("teste menu")
                }){
                    Image(systemName: "person.fill")
                        .font(Font.system(size: 22))
                    
                    
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 14)
            //.background(Color.white)
            //.clipShape(Capsule())
            .glassEffect(in: .capsule)
            .shadow(color: Color.black.opacity(0.08), radius: 10, x: 0, y: 4)
            
        }.overlay(Text("Suas Notas"))
            .padding(5)
        //Spacer()
        
    }
        
        
        
        
        
//        NavigationStack {
//            List {
//                Text("Biografia Jakob")
//                Text("Psicologia das cores")
//            }
//            .navigationTitle("Pesquisa")
//            // Modificador nativo do SwiftUI
//            .searchable(
//                text: $searchText,
//                placement: .navigationBarDrawer(displayMode: .always),
//                prompt: "Pesquisar"
//            )
//            .toolbar {
//                // O botão de lápis/edição precisa ir para a Toolbar
//                ToolbarItem(placement: .topBarTrailing) {
//                    Button(action: {}) {
//                        Image(systemName: "square.and.pencil")
//                    }
//                }
//            }
//        }
    }


#Preview {
    BarraSuperiorView()
}
