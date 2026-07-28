//
//  CriptographScreen.swift
//  PadNote
//
//  Created by Paulo Eduardo Barbosa da Silva on 20/07/26.
//

import SwiftUI

struct CriptographyScreen: View {
    
    @State var message: String = ""
    
    var body: some View {
        VStack(spacing: 50){
            TextField(text: $message, axis: .vertical){
                Text("Insira a sua chave de criptografia")
                    .foregroundStyle(.gray)
            }
                .padding(10)
                .lineLimit(5...5)
                .frame(width: 300)
                .foregroundColor(.black)
                .background(RoundedRectangle(cornerRadius: 8).foregroundStyle(.criptographyTextField))
                .padding(.horizontal)
                
            Button("Criptografar"){

            }
                .padding()
                .bold()
                .background(.buttonColors)
                .foregroundStyle(Color.white)
                .cornerRadius(20)
        }.navigationTitle("Criptografar")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

#Preview {
    NavigationStack{
        CriptographyScreen()
    }
}
