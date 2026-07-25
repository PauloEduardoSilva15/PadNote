//
//  TelaConfiguracoesView.swift
//  PadNote
//
//  Created by Lucas on 23/07/26.
//
import SwiftUI

struct TelaConfiguracoesView: View {
    
    @State var ativarSincronizacao: Bool = false
    @State var notificacoes: Bool = false
    @State var modoClaro: Bool = false
    @State var salvarNotasAutomaticamente: Bool = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Conta") {
                    Toggle("Ativar Sincronização", isOn: $ativarSincronizacao)
                }
                
                Section("Preferências") {
                    Toggle("Notificações", isOn: $notificacoes)
                    Toggle("Modo claro", isOn: $modoClaro)
                    Toggle("Salvar notas automaticamente", isOn: $salvarNotasAutomaticamente)
                }
                
                Section("Sobre") {
                    LabeledContent("Versão do aplicativo", value: "1.0")
                }
            }
            .navigationTitle("Configurações")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
#Preview {
    TelaConfiguracoesView()
}
