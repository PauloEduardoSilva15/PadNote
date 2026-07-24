//
//  CriptographScreen.swift
//  PadNote
//
//  Created by Paulo Eduardo Barbosa da Silva on 20/07/26.
//

import SwiftUI

struct CriptographyScreen: View {
    var body: some View {
        VStack(spacing: 200){
            HStack{
                Text("Criptografar")
                    .font(.title)
            }
            VStack(spacing: 30){
                TextField("Insira a sua chave de criptografia", text: .constant(""), axis: .vertical)
                    .padding(10)
                    .lineLimit(5...5)
                    .frame(width: 300, height: 150)
                    .background(RoundedRectangle(cornerRadius: 8).foregroundStyle(.criptographyTextField))
                    .padding(.horizontal)
                
                Button("Criptografar"){

                }
                .padding()
                .bold()
                .background(.buttonColors)
                .foregroundStyle(Color.white)
                .cornerRadius(20)
            }

            
        }.padding(.bottom, 200)
        
    }
}

#Preview {
    CriptographyScreen()
}
