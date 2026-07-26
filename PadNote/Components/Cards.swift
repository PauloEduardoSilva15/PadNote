//
//  Cards.swift
//  PadNote
//
//  Created by Lucas on 21/07/26.
//

import SwiftUI
/*
public struct Cards: View {
    @State private var selecionado: Bool = false
    @Binding var jaHouveSelecao: Bool
    @Binding var qtdSelecionados: Int
    public var body: some View {
        VStack(alignment: .leading){
            Text("Texto 1 do primeiro teste")
            Spacer()
        }
        .frame(width: 138, height: 171)
        //.background(Color.white.opacity(0.8))
        .background(selecionado ? Color.blue : Color.white.opacity(0.8))
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.2), radius: 15, x: 0, y: 8)
        .contentShape(Rectangle())
        .onTapGesture {
            if qtdSelecionados > 0 && !selecionado {
                qtdSelecionados += 1
                selecionado = true
                print("qtdselecionados > 0 e !selecionado qtdSelecionados: \(qtdSelecionados)")
            }
            else if selecionado {
                qtdSelecionados -= 1
                selecionado = false
                
                print("selecionado qtdSelecionados: \(qtdSelecionados)")
            }
        }
        .onLongPressGesture(minimumDuration: 0.8) {
            if qtdSelecionados == 0 && !selecionado {
                withAnimation(.spring()) {
                    selecionado = true
                    jaHouveSelecao = true
                    qtdSelecionados += 1
                    print("qtdSelecionados == 0 && qtdSelecionados: \(qtdSelecionados)")
                }
            }
        }
        
    }
}

#Preview {
    Cards(jaHouveSelecao: .constant(false), qtdSelecionados: .constant(20))
}
*/

import SwiftUI

public struct Cards: View {
    let note: Note
    @Binding var isSelected: Bool
    let onTap: () -> Void
    let onLongPress: () -> Void
    
    public var body: some View {
        VStack{
            VStack{
                Text(note.content)
                    .font(.caption)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.secondary)
                    .lineLimit(3)
                
            }
            //.padding()
            .frame(width: 138, height: 171)
            .background(isSelected ? Color.blue.opacity(0.2) : Color.white.opacity(0.8))
            .cornerRadius(15)
            .shadow(color: Color.black.opacity(0.2), radius: 15, x: 0, y: 8)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 2)
            )
            .contentShape(Rectangle())
            .onTapGesture(perform: onTap)
            .onLongPressGesture(minimumDuration: 0.8, perform: onLongPress)
            Text(note.title)
                .font(.headline)
                .lineLimit(1)
        }
        
        
    }
}
