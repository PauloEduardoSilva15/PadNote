//
//  ConfirmCriptographyScreen.swift
//  PadNote
//
//  Created by Paulo Eduardo Barbosa da Silva on 22/07/26.
//

import SwiftUI

struct ConfirmCriptographyScreen: View {
    var body: some View {
        VStack(spacing: 100){
                CriptografiedMensager()
                Button("Voltar a tela inicial"){

                }
                .padding()
                .background(.buttonColors)
                .foregroundStyle(Color.white)
                .bold()
                .cornerRadius(20)
            
        }.navigationTitle("Criptografado")
            .navigationBarTitleDisplayMode(.inline)
        
    }
}

#Preview {
    NavigationStack {
        ConfirmCriptographyScreen()
    }
    
}
