//
//  PageButton.swift
//  StarWars
//
//  Created by JoseAlvarez on 8/29/25.
//

import SwiftUI

struct PageButton: View {
    
    let number: Int
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button("\(number)") {
            withAnimation(.easeInOut(duration: 0.3)) {
                action()
            }
        }
        .frame(width: 25, height: 25)
        .background(isSelected ? Color.blue : Color.gray)
        .foregroundColor(.white)
        .cornerRadius(8)
        .disabled(isSelected)
    }
}
