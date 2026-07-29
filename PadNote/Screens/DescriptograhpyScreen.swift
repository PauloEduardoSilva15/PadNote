//
//  Descriptography.swift
//  PadNote
//
//  Created by Paulo Eduardo Barbosa da Silva on 22/07/26.
//

import SwiftUI

struct DescriptographyScreen: View {
    @State var chaveDescriptografar1: String = ""
    @State private var mostrarErroDescriptografia: Bool = false
    @Environment(NoteManager.self) private var notaManager
    @Environment(\.navigationPath) private var path

    private var chaveValida: Bool {
        !chaveDescriptografar1.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var body: some View {
        VStack(spacing: 32) {

            VStack(spacing: 12) {
                Image(systemName: "lock.open.rotation")
                    .font(.system(size: 44, weight: .medium))
                    .foregroundStyle(.buttonColors)
                Text("Digite a chave de criptografia para desbloquear sua nota")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)
            }
            .padding(.top, 24)

            VStack(alignment: .leading, spacing: 8) {

                TextField("Insira sua chave aqui", text: $chaveDescriptografar1, axis: .vertical)
                    .lineLimit(5...5)
                    .padding(16)
                    .foregroundStyle(.primary)
                    .background(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(.criptographyTextField)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .strokeBorder(Color.black.opacity(0.06), lineWidth: 1)
                    )
            }
            .padding(.horizontal, 24)

            Spacer()

            Button(action: descriptografar) {
                Text("Descriptografar")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
            }
            .background(chaveValida ? Color.buttonColors : Color.gray.opacity(0.4))
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .disabled(!chaveValida)
            .padding(.horizontal, 24)
            .padding(.bottom, 24)
        }
        .navigationTitle("Descriptografar")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Chave incorreta", isPresented: $mostrarErroDescriptografia) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Não foi possível descriptografar a nota com essa chave. Verifique e tente novamente.")
        }
    }

    private func descriptografar() {
        if let notaCriptografada = notaManager.notes.first(where: { $0.estaCriptografado }) {
            let sucesso = notaManager.decryptNote(
                note: notaCriptografada,
                chaveDescriptografar: chaveDescriptografar1
            )
            if sucesso {
                path.wrappedValue = NavigationPath()
            } else {
                mostrarErroDescriptografia = true
            }
        }
    }
}

#Preview {
    NavigationStack {
        DescriptographyScreen()
            .environment(NoteManager())
    }
}
