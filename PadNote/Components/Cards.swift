//
//  Cards.swift
//  PadNote
//
//  Created by Lucas on 21/07/26.
//

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
                    .foregroundColor(.gray)
                    .lineLimit(3)
                
            }
            //.padding()
            .frame(width: 138, height: 171)
            .background(isSelected ? Color.blue.opacity(0.2) : Color.white)
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
