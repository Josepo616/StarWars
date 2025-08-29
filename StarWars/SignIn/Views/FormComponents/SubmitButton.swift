//
//  SubmitButton.swift
//  StarWars
//
//  Created by JoseAlvarez on 8/28/25.
//

import SwiftUI

struct SubmitButton: View {

    var isEnabled: Bool

    var body: some View {
        Text("Submit")
            .frame(maxWidth: .infinity)
            .padding()
            .background(!isEnabled ? Color.blue : Color.gray)
            .foregroundColor(.white)
            .cornerRadius(8)
        
    }
}
