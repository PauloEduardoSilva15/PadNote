//
//  NoteScreen.swift
//  PadNote
//
//  Created by Paulo Eduardo Barbosa da Silva on 24/07/26.
//

import SwiftUI

struct NoteScreen: View {
    @State var note: String = ""
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
    
    @State var selectedAlignmentPath: String = "text.alignleft"
    @State var selectedAlignment: TextAlignment = .leading
    @State var selectedSize: CGFloat = 16
    @State var selectedFont: String = "Helvetica"
    @State var selectedColor: Color = .black
    @State var isBold: Bool = false
    @State var isItalic: Bool = false
    
    var body: some View {
        VStack{
            Text("Nome da nota")
                .font(.title2)
            Divider()
            ZStack{
                TextEditor(text: $note)
                    .foregroundStyle(selectedColor)
                    .font(.custom(selectedFont, size: selectedSize))
                    .multilineTextAlignment(selectedAlignment)
                    .bold(isBold)
                    .italic(isItalic)
                    .padding()
                    .lineSpacing(5)
                HStack{

                    Menu{
                        ScrollView {
                            ForEach(systemFonts, id: \.self) { fontName in
                                Button(fontName) {
                                    selectedFont = fontName
                                }
                                    .font(.custom(fontName, size: 14))
                            }
                        }
                                                .frame(maxHeight: 300)
                    }label:{
                        Image(systemName: "textformat")
                    }
                    
                    DivideMenuTexBox()
                    
                    Menu("\(Int(selectedSize))pt"){
                        ForEach(fontsSize, id: \.self){index in
                            Button("\(index)pt"){
                                selectedSize = CGFloat(index)
                            }
                        }
                    }
                    DivideMenuTexBox()
                    
                    Menu{
                        ForEach(fontsAlignment, id: \.self){index in
                            Button{
                                selectedAlignmentPath = index
                                if let alignment = alignmentDictionarie[index]{
                                    selectedAlignment = alignment
                                }
                                else {
                                    selectedAlignment = .leading
                                }
                            }label:{
                                Image(systemName: index)
                            }
                            
                        }
                    }label: {
                        Image(systemName: selectedAlignmentPath)
                    }
                    DivideMenuTexBox()
                    
                    Button{
                        isBold.toggle()
                        
                    }label:{
                        Image(systemName: "bold")
                    }
                    DivideMenuTexBox()
                    
                    Button{
                        isItalic.toggle()
                    }label:{
                        Image(systemName: "italic")
                    }
                    DivideMenuTexBox()
                    
                    ColorPicker("Color Selected", selection: $selectedColor)
                        .labelsHidden()
                    
                    DivideMenuTexBox()
                    
                    Button{
                        
                    }label:{
                        Image(systemName: "barcode.viewfinder")
                    }
                    
                }.foregroundColor(.black)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                    .background(
                        Capsule()
                            .fill(.menu)
                            
                    )
                    .padding()

            }
        }
    }
}
            



#Preview {
    NoteScreen()
}
