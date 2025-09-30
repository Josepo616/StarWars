//
//  ContentView.swift
//  StarWars
//
//  Created by JoseAlvarez on 8/28/25.
//

import SwiftUI

struct ContentView: View {

    @StateObject var viewModel: PlanetsViewModel

    var body: some View {
        if let error = viewModel.apiError {
            NoDataView(error: error, viewModel: viewModel)
        } else if viewModel.loadingComplete && viewModel.planets.isEmpty {
            Text("No planets found.")
        } else {
            PlanetListView(viewModel: viewModel)
        }
    }
}
