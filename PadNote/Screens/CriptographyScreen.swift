//
//  CriptographScreen.swift
//  PadNote
//
//  Created by Paulo Eduardo Barbosa da Silva on 20/07/26.
//

import SwiftUI

struct CriptographyScreen: View {
    var body: some View {
        VStack(spacing: 300){
            HStack{
                Text("Criptografia")
            }
            TextField("Insira a sua chave de criptografia", text: .constant("")).textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            Button("Criptografar"){

            }
            .padding()
            .background(.buttonColors)
            .foregroundStyle(Color.white)
            .cornerRadius(20)

            
        }.ignoresSafeArea()
        
    }
}

#Preview {
    CriptographyScreen()
}
