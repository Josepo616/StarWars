//
//  MainListView.swift
//  StarWars
//
//  Created by JoseAlvarez on 8/27/25.
//

import Combine
import SwiftUI

struct PlanetsView: View {
    @StateObject private var viewModel = PlanetsViewModel()

    var body: some View {
        VStack {
            if !viewModel.loadingComplete {
                LoadingView()
            } else {
                ContentView(viewModel: viewModel)
            }
        }
        .onAppear {
            viewModel.loadMoviesOnAppStart()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Text("Planets")
                    .multilineTextAlignment(.center)
            }
        }

    }
}

struct LoadingView: View {
    var body: some View {
        ProgressView("Loading planets...")
            .progressViewStyle(CircularProgressViewStyle())
            .padding()
    }
}

struct ContentView: View {
    @ObservedObject var viewModel: PlanetsViewModel

    var body: some View {
        if viewModel.planets.isEmpty {
            NoDataView()
        } else {
            PlanetListView(viewModel: viewModel)
        }
    }
}

struct NoDataView: View {
    var body: some View {
        Text("Planets not found...")
            .font(.headline)
            .foregroundColor(.gray)
            .padding()
    }
}

struct PlanetListView: View {
    @ObservedObject var viewModel: PlanetsViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                ForEach(viewModel.planets) { planet in
                    NavigationLink(
                        destination: PlanetDetailView(planet: planet)
                    ) {
                        PlanetRowView(planet: planet)
                    }
                }
            }
        }
    }
}

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

struct PlanetDetailView: View {
    var planet: PlanetsModel

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(planet.name)
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("Climate: \(planet.climate)")
            Text("Diameter: \(planet.diameter) km")
            Text("Population: \(planet.population)")
            Text("Gravity: \(planet.gravity)")
            Text("Terrain: \(planet.terrain)")
        }
        .padding()
    }
}

struct PlanetsView_Previews: PreviewProvider {
    static var previews: some View {
        PlanetsView()
    }
}

#Preview {
    PlanetsView()
}
