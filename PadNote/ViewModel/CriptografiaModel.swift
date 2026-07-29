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
    
    func descriptografar(mensagemCriptografada: String, chave: String) -> String {
        do {
            guard let msgData = Data(base64Encoded: mensagemCriptografada),
                  let chaveData = Data(base64Encoded: chave) else {
                return "Chave ou mensagem em formato invalido"
            }
            
            guard [16, 24, 32].contains(chaveData.count) else {
                return "Tamanho de chave incorreto"
            }
            let chaveSymmetric = SymmetricKey(data: chaveData)
            let caixaSelada = try AES.GCM.SealedBox(combined: msgData)
            let mensagemOriginal = try AES.GCM.open(caixaSelada, using: chaveSymmetric)
            
            return String(data: mensagemOriginal, encoding: .utf8) ?? "Erro na conversão de texto"
        } catch {
            print("Erro ao descriptografar: \(error)")
            return "Chave incorreta"
        }
    }
}
