//
//  BarraInferiorView.swift
//  PadNote
//
//  Created by Lucas on 25/07/26.
//

import SwiftUI

struct BarraInferiorView: View {
    let onDelete: () -> Void
    let onMove: () -> Void
    let onEncrypt: () -> Void
    let onShare: () -> Void
    @State private var alertaCriptografar: Bool = false
    @State private var alertaExcluir: Bool = false
    @State private var telaCriptografia: Bool = false
    @State private var telaCompartilhar: Bool = false
    @State private var telaMover: Bool = false
    @Binding var pastas: Set<String>
    

    
    
    
    var body: some View {
        HStack {
            Spacer()
            
            BotaoBarraView(titulo: "Mover", icone: "arrow.forward.folder") {
                onMove()
                telaMover = true
            }.sheet(isPresented: $telaMover){
                NavigationView {
                        List {
                            ForEach(Array(pastas), id: \.self) { pasta in
                                Button(action: {
                                    print("Nota movida para: \(pasta)")
                                    
                                    telaMover = false
                                }) {
                                    HStack {
                                        Image(systemName: "folder")
                                            .foregroundColor(.blue)
                                        Text(pasta)
                                            .foregroundColor(.primary)
                                    }
                                }
                            }
                        }
                        .navigationTitle("Mover para...")
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button(action: {
                                    telaMover = false
                                }){
                                    Image(systemName:"multiply")
                                }
                            }
                        }
                    }
            }
            
            Spacer()
            
            BotaoBarraView(titulo: "Criptografar", icone: "lock") {
                onEncrypt()
                alertaCriptografar = true
            }.alert("Deseja criptografar essa nota?", isPresented: $alertaCriptografar) {
                Button("Sim") {
                    telaCriptografia = true

                }
                
                Button("Não", role: .cancel) {
                    
                }
            } message: {
                Text("Após a criptografia você só poderá descriptografar com a chave de acesso.")
            }.navigationDestination(isPresented: $telaCriptografia){
                CriptographyScreen()
            }
            
            Spacer()
            
            BotaoBarraView(titulo: "Compartilhar", icone: "square.and.arrow.up"){
                onShare()
                telaCompartilhar = true
            }.sheet(isPresented: $telaCompartilhar){
                ZStack{
                    Image("backgroundCompartilhar")
                            //.resizable()
                        .scaleEffect(0.67)
                            //.scaledToFill()
                            .ignoresSafeArea()

                }
            }
            
            Spacer()
            
            BotaoBarraView(titulo: "Excluir", icone: "trash", isDestructive: true) {
                alertaExcluir = true
            }.alert("Deseja excluir essa nota?", isPresented: $alertaExcluir) {
                Button("Excluir", role: .destructive) {
                    onDelete()
                    
                }
                
                Button("Cancelar", role: .cancel) { }
            } message: {
                Text("Após essa ação a nota será excluída. Essa ação não poderá ser desfeita.")
            }
            
            Spacer()
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .glassEffect(in: Capsule())
        
    }
}

#Preview {
    NavigationStack {
        
        
        ZStack {
            LinearGradient(colors: [.blue, .purple], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                BarraInferiorView(
                    onDelete: {},
                    onMove: {},
                    onEncrypt: {},
                    onShare: {},
                    pastas: .constant(["teste1","teste2"])
                )
                .padding(.horizontal)
            }
        }
    }
}
