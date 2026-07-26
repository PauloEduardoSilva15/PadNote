//
//  BarraDeBuscaView.swift
//  PadNote
//
//  Created by Lucas on 21/07/26.
//

import SwiftUI

public struct BarraDeBuscaView: View {
    @Binding var searchText: String
    let onCreateNote: () -> Void
    
    public var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .font(Font.system(size: 22))
                TextField("Buscar", text: $searchText)
                Spacer()
            }
            .padding()
            .frame(width: 268, height: 47)
            .glassEffect(.regular, in: .rect(cornerRadius: 24))
            
            Button(action: onCreateNote) {
                Image(systemName: "square.and.pencil")
                    .fontWeight(.bold)
                    .font(Font.system(size: 22))
            }
            .padding()
            .glassEffect(in: .circle)
        }
    }
}

#Preview {
    BarraDeBuscaView(searchText: .constant(""), onCreateNote: {})
}
