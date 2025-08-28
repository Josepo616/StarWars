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
        .navigationTitle(Text("Planets"))
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    PlanetsView()
}
