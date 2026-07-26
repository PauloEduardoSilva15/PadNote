//
//  Nota.swift
//  PadNote
//
//  Created by Lucas on 25/07/26.
//

import SwiftData

@Model
class Nota {
    var titulo: String
    var conteudo: String
    
    init(titulo: String, conteudo: String) {
        self.titulo = titulo
        self.conteudo = conteudo
    }
}
