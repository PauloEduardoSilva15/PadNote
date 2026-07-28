//
//  Descriptography.swift
//  PadNote
//
//  Created by Paulo Eduardo Barbosa da Silva on 22/07/26.
//

import SwiftUI

struct DescriptographyScreen: View {
    @State var message: String = ""
    var body: some View {
            VStack(spacing: 50){
                TextField(text: $message, axis: .vertical){
                    Text("Insira a sua chave de criptografia")
                        .foregroundStyle(.gray)
                }
                .frame(width: 300)
                .padding()
                .lineLimit(5...5)
                .foregroundColor(.black)
                .background(RoundedRectangle(cornerRadius: 8).foregroundStyle(.criptographyTextField))
                    
                    
                Button("Descriptografar"){

                }
                    .padding()
                    .bold()
                    .background(.buttonColors)
                    .foregroundStyle(Color.white)
                    .cornerRadius(20)
            }.navigationTitle("Descriptografar")
            .navigationBarTitleDisplayMode(.inline)
        
    }
}

#Preview {
    NavigationStack{
        DescriptographyScreen()
    }
}
