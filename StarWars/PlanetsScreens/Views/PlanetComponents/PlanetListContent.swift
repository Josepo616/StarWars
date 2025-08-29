//
//  PlanetListContent.swift
//  StarWars
//
//  Created by JoseAlvarez on 8/29/25.
//

import SwiftUI

struct PlanetListContent: View {

    let planets: [PlanetsModel]

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            ForEach(planets) { planet in
                PlanetRowView(planet: planet)
            }
        }
        .padding()
    }
}
