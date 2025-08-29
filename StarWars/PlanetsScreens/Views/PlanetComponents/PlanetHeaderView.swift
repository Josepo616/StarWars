//
//  PlanetHeaderView.swift
//  StarWars
//
//  Created by JoseAlvarez on 8/28/25.
//

import SwiftUI

struct PlanetHeaderView: View {
    
    var planet: PlanetsModel

    var body: some View {
        HStack {
            Text(planet.name)
                .font(.headline)
                .fontWeight(.semibold)
            Spacer()
            Text(planet.climate)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
}
