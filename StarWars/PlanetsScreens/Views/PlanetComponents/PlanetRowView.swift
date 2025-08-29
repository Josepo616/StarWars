//
//  PlanetRowView.swift
//  StarWars
//
//  Created by JoseAlvarez on 8/28/25.
//

import SwiftUI

struct PlanetRowView: View {

    var planet: PlanetsModel

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            PlanetHeaderView(planet: planet)
            PlanetDetailsView(planet: planet)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.1))
        )
        .padding(.horizontal)
    }
}
