//
//  BarraDePastasView.swift
//  PadNote
//
//  Created by Lucas on 22/07/26.
//
import SwiftUI

struct BarraDePastasView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(FolderManager.self) private var folderManager
    @Environment(NoteManager.self) private var noteManager
    @Binding var menuIniciado: Bool
    @State var nomePasta: String = ""
    @State var abrirSheet = false
    @State var pastaParaRenomear: Folder?
    @State var novoNomePasta: String = ""
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            HStack {
                Rectangle()
                    .cornerRadius(20)
                    .foregroundStyle(colorScheme == .light ? .white : .black)
                    .ignoresSafeArea()
                    .containerRelativeFrame(.horizontal) { size, axis in
                        size * 0.66
                    }
            }
            VStack {
                HStack {
                    Button(action: {
                        menuIniciado.toggle()
                    }) {
                        Image(systemName: "chevron.backward")
                            .padding(10)
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(colorScheme == .light ? .black : .white)
                            .glassEffect(in: .circle)
                            .shadow(color: Color.black.opacity(0.08), radius: 10, x: 0, y: 4)
                    }
                    Text("Suas pastas")
                        .font(.system(size: 17, weight: .semibold))
                        .padding(.horizontal, 10)
                    Spacer()
                }.padding()
                
                HStack {
                    VStack(alignment: .leading, spacing: 15) {
                        // Mostra todas as pastas
                        ForEach(folderManager.folders.sorted(by: { $0.name < $1.name }), id: \.id) { pasta in
                            HStack {
                                HStack {
                                    Image(systemName: "folder")
                                        .foregroundColor(.primary)
                                    Text(pasta.name)
                                        .fontWeight(pasta.id == folderManager.selectedFolderId ? .semibold : .regular)
                                }
                                .font(Font.system(size: 22, weight: .regular))
                                .onTapGesture {
                                    folderManager.selectFolder(pasta)
                                    menuIniciado.toggle()
                                }
                                
                                Spacer()
                                
                            }
                        }
                        
                        // Botão de adicionar pasta
                        HStack {
                            Button(action: {
                                abrirSheet.toggle()
                            }) {
                                Image(systemName: "folder.badge.plus")
                                Text("Adicionar Pasta")
                            }
                        }
                        .font(Font.system(size: 22, weight: .regular))
                        .buttonStyle(.plain)
                    }
                    Spacer()
                }.padding()
            }
        }
        .sheet(isPresented: $abrirSheet) {
            VStack(spacing: 25) {
                HStack {
                    Button(action: {
                        nomePasta = ""
                        abrirSheet.toggle()
                    }) {
                        Image(systemName: "multiply")
                            .font(Font.system(size: 22, weight: .bold))
                    }
                    .padding()
                    .glassEffect(in: .circle)
                    .shadow(color: Color.black.opacity(0.08), radius: 10, x: 0, y: 4)
                    
                    Spacer()
                    Text("Adicionar pasta")
                    Spacer()
                    Button(action: {
                        folderManager.createFolder(name: nomePasta)
                        nomePasta = ""
                        abrirSheet.toggle()
                    }) {
                        Image(systemName: "checkmark")
                            .font(Font.system(size: 22, weight: .bold))
                    }
                    .padding()
                    .glassEffect(in: .circle)
                    .shadow(color: Color.black.opacity(0.08), radius: 10, x: 0, y: 4)
                }.padding()
                
                VStack {
                    TextField("Nome da pasta", text: $nomePasta)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                }
                .padding()
                Spacer()
            }
        }
        .alert("Renomear Pasta", isPresented: .constant(pastaParaRenomear != nil)) {
            TextField("Novo nome", text: $novoNomePasta)
            Button("Cancelar", role: .cancel) {
                pastaParaRenomear = nil
                novoNomePasta = ""
            }
            Button("Salvar") {
                if let pasta = pastaParaRenomear {
                    folderManager.renameFolder(pasta, newName: novoNomePasta)
                    pastaParaRenomear = nil
                    novoNomePasta = ""
                }
            }
        } message: {
            Text("Digite o novo nome da pasta")
        }
    }
}

#Preview {
    let folderManager = FolderManager()
    let noteManager = NoteManager()
    
    // Adiciona algumas pastas de exemplo
    folderManager.createFolder(name: "Trabalho")
    folderManager.createFolder(name: "Pessoal")
    
    return BarraDePastasView(menuIniciado: .constant(false))
        .environment(folderManager)
        .environment(noteManager)
}
