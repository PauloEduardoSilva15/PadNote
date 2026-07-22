//
//  Cards.swift
//  PadNote
//
//  Created by Lucas on 21/07/26.
//

import SwiftUI

public struct Cards: View {
    public var body: some View {
        VStack(alignment: .leading){
            Text("Texto 1 do primeiro teste")
            Spacer()
        }
        .frame(width: 138, height: 171)
        .background(Color.white.opacity(0.8))
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.2), radius: 15, x: 0, y: 8)
    }

}
#Preview {
    Cards()
}
