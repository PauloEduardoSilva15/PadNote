//
//  NoteScreen.swift
//  PadNote
//
//  Created by Paulo Eduardo Barbosa da Silva on 24/07/26.
//

import SwiftUI

struct NoteScreen: View {
    @State var note: String = ""
    let fonts: [String] = ["8pt","10pt","12pt","14pt","16pt","20pt"]
    let fontsAlignment: [String] = ["left","center","right", "justify"]
    @State var selectedFont: String = "14pt"
    
    var body: some View {
        VStack{
            Text("Nome da nota")
                .font(.title2)
            Divider()
            ZStack{
                TextEditor(text: $note)
                    .padding()
                    .lineSpacing(5)
                HStack{
                    Menu{
                        Button("Helvetica"){
                        
                        }
                        Button("São Francisco"){
                            
                        }
                        Button("Arial"){
                            
                        }
                    }label:{
                        Image(systemName: "textformat")
                    }
                    
                    Divider()
                        .frame(height: 20)
                        .background(Color.white.opacity(0.3))
                    Menu(selectedFont){
                        ForEach(fonts, id: \.self){index in
                            Button(index){
                                selectedFont = index
                            }
                            
                        }
                    }
                    Divider()
                        .frame(height: 20)
                        .background(Color.white.opacity(0.3))
                    
                    Button{
                        
                    }label:{
                        Image(systemName: "barcode.viewfinder")
                    }
                    Divider()
                        .frame(height: 20)
                        .background(Color.white.opacity(0.3))
                    
                        
                    
                }.foregroundColor(.black)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background(
                        Capsule()
                            .fill(.menu)
                            
                    )
                    .padding()

            }
        }
    }
}
            



#Preview {
    NoteScreen()
}
