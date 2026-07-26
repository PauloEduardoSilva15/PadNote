//
//  testeCripotografiaView.swift
//  PadNote
//
//  Created by Lucas on 25/07/26.
//

import SwiftUI

struct testeCripotografiaView: View {
    @State private var vm = CriptografiaModel()
    @State var text: String = ""
    var body: some View {
        VStack{
            TextField("digite texto", text: $text)
            
            Button("Criptografar"){
                let resultado = vm.criptografar(texto: self.text)
                vm.descriptografar(mensagemCriptografada: resultado?.mensagem ?? "", chave: resultado?.chave ?? "")
                }
            }.padding(20)
        }
    }

#Preview {
    testeCripotografiaView()
}
