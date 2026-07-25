//
//  BarraSuperiorView.swift
//  PadNote
//
//  Created by Lucas on 21/07/26.
//

import SwiftUI
struct BarraSuperiorView: View {
    @Binding var menuIniciado: Bool
    
    var body: some View {
        ZStack{
            
            
            HStack{
                //Spacer()
                //Botoes de configuracao e conta
                Button(action: {
                    withAnimation(.easeOut){
                        menuIniciado.toggle()
                    }
                }){
                    Image(systemName: "folder.fill")
                        .font(Font.system(size: 22))
                        .padding(.horizontal, 20)
                        .padding(.vertical, 14)
                    //.background(Color.white)
                        .glassEffect(in: .circle)
                    //.clipShape(Circle())
                        .shadow(color: Color.black.opacity(0.08), radius: 10, x: 0, y: 4)
                    
                }
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
        }  
    }
}


#Preview {
    BarraSuperiorView(menuIniciado: .constant(false))
}
