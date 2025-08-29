//
//  PlanetDetailsView.swift
//  StarWars
//
//  Created by JoseAlvarez on 8/28/25.
//

import SwiftUI

struct PlanetDetailsView: View {

    var planet: PlanetsModel

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            PlanetDetailRow(title: "Diameter", value: "\(planet.diameter) km")
            PlanetDetailRow(
                title: "Population",
                value: String(planet.population)
            )
            PlanetDetailRow(title: "Gravity", value: planet.gravity)
            PlanetDetailRow(title: "Terrain", value: planet.terrain)
        }
    }
}
