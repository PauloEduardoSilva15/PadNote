//
//  BarraInferiorView.swift
//  PadNote
//
//  Created by Lucas on 25/07/26.
//

import SwiftUI

struct BarraInferiorView: View {
    @Environment(FolderManager.self) private var folderManager
    @Environment(NoteManager.self) private var noteManager
    @Environment(\.navigationPath) private var path

    let onDelete: () -> Void
    let onShare: () -> Void

    @State private var alertaCriptografar: Bool = false
    @State private var alertaExcluir: Bool = false
    @State private var telaCompartilhar: Bool = false
    @State private var telaMover: Bool = false
    @State private var mensagemFeedback: String = ""
    @State private var mostrarFeedback: Bool = false

    var body: some View {
        HStack {
            Spacer()

            BotaoBarraView(titulo: "Mover", icone: "arrow.forward.folder") {
                telaMover = true
            }
            .sheet(isPresented: $telaMover) {
                NavigationView {
                    List {
                        let pastasDisponiveis = folderManager.folders.filter { pasta in
                            if let currentFolder = folderManager.currentFolder {
                                return pasta.id != currentFolder.id
                            }
                            return true
                        }

                        if pastasDisponiveis.isEmpty {
                            Text("Nenhuma pasta disponível")
                                .foregroundColor(.secondary)
                                .padding()
                        } else {
                            ForEach(pastasDisponiveis, id: \.id) { pasta in
                                Button(action: {
                                    let selectedNotes = noteManager.selectedNotes
                                    noteManager.moveNotesToFolder(selectedNotes, folderId: pasta.id)

                                    mensagemFeedback = "Movido para \(pasta.name)"
                                    mostrarFeedback = true
                                    telaMover = false

                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                        mostrarFeedback = false
                                    }
                                }) {
                                    HStack {
                                        Image(systemName: "folder")
                                            .foregroundColor(pasta.isDefault ? .blue : .primary)
                                        Text(pasta.name)
                                            .foregroundColor(.primary)

                                        Spacer()

                                        let count = noteManager.notes.filter { $0.folderId == pasta.id }.count
                                        Text("\(count)")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
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
        .overlay(
            Group {
                if mostrarFeedback {
                    Text(mensagemFeedback)
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.green.opacity(0.8))
                        .cornerRadius(8)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                        .offset(y: -60)
                }
            }
        )
    }
}
