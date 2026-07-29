//
//  BarraInferiorView.swift
//  PadNote
//
//  Created by Lucas on 25/07/26.
//

import SwiftUI

struct BarraInferiorView: View {
    let onDelete: () -> Void
    let onMove: (Folder) -> Void
    let onEncrypt: () -> Void
    let onShare: () -> Void
    let pastas: [Folder]
    
    @Environment(\.navigationPath) private var path
    @State private var alertaCriptografar: Bool = false
    @State private var alertaExcluir: Bool = false
    @State private var telaCompartilhar: Bool = false
    @State private var telaMover: Bool = false

    var body: some View {
        HStack {
            Spacer()
            
            BotaoBarraView(titulo: "Mover", icone: "arrow.forward.folder") {
                telaMover = true
            }
            .sheet(isPresented: $telaMover) {
                NavigationView {
                    List {
                        ForEach(pastas) { pasta in
                            Button(action: {
                                onMove(pasta)
                                telaMover = false
                            }) {
                                HStack {
                                    Image(systemName: "folder")
                                        .foregroundColor(.blue)
                                    Text(pasta.name)
                                        .foregroundColor(.primary)
                                }
                            }
                        }
                    }
                    .navigationTitle("Mover para...")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: { telaMover = false }) {
                                Image(systemName: "multiply")
                            }
                        }
                    }
                }
            }
            
            Spacer()
            
            BotaoBarraView(titulo: "Criptografar", icone: "lock") {
                alertaCriptografar = true
            }
            .alert("Deseja criptografar essa nota?", isPresented: $alertaCriptografar) {
                Button("Sim") {
                    path.wrappedValue.append(RotaNavegacao.telaCriptografia1)
                }
                Button("Não", role: .cancel) { }
            } message: {
                Text("Após a criptografia você só poderá descriptografar com a chave de acesso.")
            }
            
            Spacer()
            
            BotaoBarraView(titulo: "Compartilhar", icone: "square.and.arrow.up") {
                onShare()
                telaCompartilhar = true
            }
            .sheet(isPresented: $telaCompartilhar) {
                ZStack {
                    Image("backgroundCompartilhar")
                        .scaleEffect(0.67)
                        .ignoresSafeArea()
                }
            }
            
            Spacer()
            
            BotaoBarraView(titulo: "Excluir", icone: "trash", isDestructive: true) {
                alertaExcluir = true
            }
            .alert("Deseja excluir essa nota?", isPresented: $alertaExcluir) {
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
