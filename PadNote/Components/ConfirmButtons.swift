//
//  ConfirmButtons.swift
//  PadNote
//
//  Created by Paulo Eduardo Barbosa da Silva on 22/07/26.
//

import SwiftUI

struct ConfirmButtons: View {
    var text: String
    var action: () -> Void;
    var body: some View {
        VStack(){
            Button(text){
                
            }
            .padding()
            .background(.buttonColors)
            .foregroundStyle(Color.white)
            .bold()
            .cornerRadius(20)
        }
    }
}

#Preview {
    ConfirmButtons(text: "aaaa"){
        
    }
}
