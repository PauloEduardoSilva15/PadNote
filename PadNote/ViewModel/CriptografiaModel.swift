//
//  CriptografiaModel.swift
//  PadNote
//
//  Created by Lucas on 25/07/26.
//

import Foundation
import CryptoKit

class CriptografiaModel {
    
    func criptografar(texto: String) -> (mensagem: String, chave: String)? {
        guard let mensagemData = texto.data(using: .utf8) else { return nil }
        
        let chave = SymmetricKey(size: .bits256)
        
        do {
            let caixaSelada = try AES.GCM.seal(mensagemData, using: chave)
            
            if let mensagemCriptografadaData = caixaSelada.combined {
                let mensagemBase64 = mensagemCriptografadaData.base64EncodedString()
                
                let chaveBase64 = chave.withUnsafeBytes { body in
                    Data(body).base64EncodedString()
                }
                
                return (mensagemBase64, chaveBase64)
            }
        } catch {
            print("Erro ao criptografar: \(error)")
        }
        
        return nil
    }
    
    func descriptografar(mensagemCriptografada: String, chave: String) {
        do {
            guard let msgData = Data(base64Encoded: mensagemCriptografada) else { return }
            guard let chaveData = Data(base64Encoded: chave) else { return }
            
            let chaveSymmetric = SymmetricKey(data: chaveData)
            let caixaSelada = try AES.GCM.SealedBox(combined: msgData)
            let mensagemOriginal = try AES.GCM.open(caixaSelada, using: chaveSymmetric)
            print("criptografia realizada com sucesso! sua mensagem original é: \(String(data: mensagemOriginal, encoding: .utf8) ?? "Descriptografia falhou")")
        } catch {
            print("Erro ao descriptografar: \(error)")
        }
    }
}
