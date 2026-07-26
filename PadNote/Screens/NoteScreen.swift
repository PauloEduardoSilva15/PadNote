//
//  NoteScreen.swift
//  PadNote
//
//  Created by Paulo Eduardo Barbosa da Silva on 24/07/26.
//

/*import SwiftUI

struct NoteScreen: View {
    let fontsSize: [Int] = [8,10,12,14,16,20,24,32,48,64]
    let fontsAlignment: [String] = ["text.alignleft",
                                    "text.aligncenter",
                                    "text.alignright"]
    let alignmentDictionarie: [String: TextAlignment] =
    [
        "text.alignleft": .leading,
        "text.aligncenter": .center,
        "text.alignright": .trailing
    ]
    var systemFonts: [String] {
        var fonts: [String] = []
        for family in UIFont.familyNames.sorted() {
            for font in UIFont.fontNames(forFamilyName: family) {
                fonts.append(font)
            }
        }
        return fonts
    }
    @State var note: String = "Exemplo de Texto"
    @State var selectedAlignmentPath: String = "text.alignleft"
    @State var selectedAlignment: TextAlignment = .leading
    @State var selectedSize: CGFloat = 16
    @State var selectedFont: String = "Helvetica"
    @State var isBold: Bool = false
    @State var isItalic: Bool = false
    @State var selectedColor: Color = .gray
    
    @FocusState private var campoFocado: Bool?
    
    
    
    var body: some View {
        
        VStack{
            ZStack{
                TextEditor(text: $note)
                    .foregroundStyle(selectedColor)
                    .font(.custom(selectedFont, size: selectedSize))
                    .multilineTextAlignment(selectedAlignment)
                    .bold(isBold)
                    .italic(isItalic)
                    .padding()
                    .lineSpacing(5)
            }
        }
            .navigationTitle("Nome da nota")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(spacing: 30) {
                            //Fonts
                            Menu {
                                ScrollView {
                                    ForEach(systemFonts, id: \.self) { fontName in
                                        Button(fontName) {
                                            selectedFont = fontName
                                        }
                                        .font(.custom(fontName, size: 14))
                                    }
                                }
                            } label: {
                                Image(systemName: "textformat")
                            }
                            //Size
                            Menu("\(Int(selectedSize))pt") {
                                ForEach(fontsSize, id: \.self) { index in
                                    Button("\(index)pt") {
                                        selectedSize = CGFloat(index)
                                    }
                                }
                            }
                            //Alignment
                            Menu {
                                ForEach(fontsAlignment, id: \.self) { index in
                                    Button {
                                        selectedAlignmentPath = index
                                        if let alignment = alignmentDictionarie[index] {
                                            selectedAlignment = alignment
                                        } else {
                                            selectedAlignment = .leading
                                        }
                                    } label: {
                                        Image(systemName: index)
                                    }
                                }
                            } label: {
                                Image(systemName: selectedAlignmentPath)
                            }
                            //Bold
                            Button {
                                isBold.toggle()
                            } label: {
                                Image(systemName: "bold")
                            }
                            .foregroundColor(isBold ? .blue : .primary)
                            //Italic
                            Button {
                                isItalic.toggle()
                            } label: {
                                Image(systemName: "italic")
                            }
                            .foregroundColor(isItalic ? .blue : .primary)

                            //Scanner
                            Button {
                                
                            } label: {
                                Image(systemName: "document.viewfinder.fill")
                            }
                            //Color Selection
                            ColorPicker("", selection: $selectedColor)
                                .labelsHidden()
                                .onTapGesture {
                                    campoFocado = nil
                                }
                        }
                        
                    }
                }
            }
    }
}
            



#Preview {
    NavigationStack{
        NoteScreen()
    }
    
}
*/

import SwiftUI

struct NoteScreen: View {
    @Bindable var note: Note
    let noteManager: NoteManager
    @Environment(\.dismiss) private var dismiss
    @State private var noteContent: String = ""
    
    let fontsSize: [Int] = [8,10,12,14,16,20,24,32,48,64]
    let fontsAlignment: [String] = ["text.alignleft",
                                    "text.aligncenter",
                                    "text.alignright"]
    let alignmentDictionarie: [String: TextAlignment] = [
        "text.alignleft": .leading,
        "text.aligncenter": .center,
        "text.alignright": .trailing
    ]
    
    var systemFonts: [String] {
        var fonts: [String] = []
        for family in UIFont.familyNames.sorted() {
            for font in UIFont.fontNames(forFamilyName: family) {
                fonts.append(font)
            }
        }
        return fonts
    }
    
    @State private var selectedAlignmentPath: String = "text.alignleft"
    @State private var selectedAlignment: TextAlignment = .leading
    @State private var selectedSize: CGFloat = 16
    @State private var selectedFont: String = "Helvetica"
    @State private var isBold: Bool = false
    @State private var isItalic: Bool = false
    @State private var selectedColor: Color = .gray
    
    
    var body: some View {
        VStack {
            ZStack {
                TextEditor(text: $noteContent)
                    .foregroundStyle(selectedColor)
                    .font(.custom(selectedFont, size: selectedSize))
                    .multilineTextAlignment(selectedAlignment)
                    .bold(isBold)
                    .italic(isItalic)
                    .padding()
                    .lineSpacing(5)
                    .onChange(of: noteContent) { _, newValue in
                        note.content = newValue
                        note.updatedAt = Date()
                    }
            }
        }
        .navigationTitle(note.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            
            ToolbarItemGroup(placement: .keyboard) {
                ScrollView(.horizontal, showsIndicators: true) {
                    HStack(spacing: 30) {
                        Menu {
                            ScrollView {
                                ForEach(systemFonts, id: \.self) { fontName in
                                    Button(fontName) {
                                        selectedFont = fontName
                                    }
                                    .font(.custom(fontName, size: 14))
                                }
                            }
                        } label: {
                            Image(systemName: "textformat")
                        }
                        
                        Menu("\(Int(selectedSize))pt") {
                            ForEach(fontsSize, id: \.self) { index in
                                Button("\(index)pt") {
                                    selectedSize = CGFloat(index)
                                }
                            }
                        }
                        
                        Menu {
                            ForEach(fontsAlignment, id: \.self) { index in
                                Button {
                                    selectedAlignmentPath = index
                                    if let alignment = alignmentDictionarie[index] {
                                        selectedAlignment = alignment
                                    } else {
                                        selectedAlignment = .leading
                                    }
                                } label: {
                                    Image(systemName: index)
                                }
                            }
                        } label: {
                            Image(systemName: selectedAlignmentPath)
                        }
                        
                        Button {
                            isBold.toggle()
                        } label: {
                            Image(systemName: "bold")
                        }
                        .foregroundColor(isBold ? .blue : .primary)
                        
                        Button {
                            isItalic.toggle()
                        } label: {
                            Image(systemName: "italic")
                        }
                        .foregroundColor(isItalic ? .blue : .primary)
                        
                        Button {
                            // Implementar scanner
                        } label: {
                            Image(systemName: "document.viewfinder.fill")
                        }
                        
                        ColorPicker("", selection: $selectedColor)
                            .labelsHidden()
                    }
                }
            }
        }
        .onAppear {
            noteContent = note.content
        }
        .onDisappear {
            note.updatedAt = Date()
        }
    }
}
