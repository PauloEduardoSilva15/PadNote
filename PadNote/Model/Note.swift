//
//  Note.swift
//  PadNote
//
//  Created by Paulo Eduardo Barbosa da Silva on 25/07/26.
//

import SwiftUI
import Combine

import Observation

@Observable
class Note{
    var id: UUID = UUID()
    var title: String = ""
    var content: String = ""
    var font: Font = .body
    var fontSize: CGFloat = 14
    
    func rename(to title: String) {
        self.title = title
    }
    func font(to font: Font) {
        self.font = font
    }
    
}
