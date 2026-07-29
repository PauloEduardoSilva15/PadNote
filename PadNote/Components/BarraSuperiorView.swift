//
//  BarraSuperiorView.swift
//  PadNote
//
//  Created by Lucas on 21/07/26.
//

import SwiftUI
struct BarraSuperiorView: View {
    @Environment(FolderManager.self) private var folderManager
    @Binding var menuIniciado: Bool
    
    
    var body: some View {
        ZStack{
            
            
            HStack{
                Button(action: {
                    withAnimation(.easeOut){
                        menuIniciado.toggle()
                    }
                }){
                    Image(systemName: "folder.fill")
                        .font(Font.system(size: 22))
                        .padding(.horizontal, 20)
                        .padding(.vertical, 14)
                        .glassEffect(in: .circle)
                        .shadow(color: Color.black.opacity(0.08), radius: 10, x: 0, y: 4)
                    
                }
                Spacer()
                
                HStack(spacing: 20){
                    NavigationLink(destination: TelaConfiguracoesView()){
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
                .glassEffect(in: .capsule)
                .shadow(color: Color.black.opacity(0.08), radius: 10, x: 0, y: 4)
                
            }.overlay(Text(folderManager.currentFolder?.name ?? "Todas as Notas"))
                .padding(5)
        }  
    }
}


#Preview {
    let folderManager = FolderManager()
        folderManager.createFolder(name: "Trabalho")
        folderManager.createFolder(name: "Pessoal")
        folderManager.selectFolder(folderManager.customFolders.first!)
        
        return BarraSuperiorView(menuIniciado: .constant(false))
            .environment(folderManager)
}
