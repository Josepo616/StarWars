//
//  PlanetDetailRow.swift
//  StarWars
//
//  Created by JoseAlvarez on 8/28/25.
//

import SwiftUI

struct PlanetDetailRow: View {

    var title: String
    var value: String

    var body: some View {
        HStack {
            Text("\(title): \(value)")
                .font(.subheadline)
                .foregroundColor(.secondary)
            Spacer()
        }
    }
}
