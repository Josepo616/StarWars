//
//  PlanetListView.swift
//  StarWars
//
//  Created by JoseAlvarez on 8/28/25.
//

import SwiftUI

struct PlanetListView: View {
    @ObservedObject var viewModel: PlanetsViewModel
    
    @State private var currentPage: Int = 0
    private let itemsPerPage: Int = 4
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 20) {
                ForEach(currentPageItems) { planet in
                    //NavigationLink(destination: PlanetDetailView(planet: planet)) {
                        PlanetRowView(planet: planet)
                    //}
                }
            }
            .padding()
            Spacer()
            
            HStack {
                Button("Back") {
                    if currentPage > 0 {
                        currentPage -= 1
                    }
                }
                .disabled(currentPage == 0)
                
                Button("Next") {
                    if currentPage < totalPages - 1 {
                        currentPage += 1
                    }
                }
                .disabled(currentPage >= totalPages - 1)
            }
        }
        .padding()
    }
    
    
    private var totalPages: Int {
        max(1, Int(ceil(Double(viewModel.planets.count) / Double(itemsPerPage))))
    }
    
    private var currentPageItems: [PlanetsModel] {
        let startIndex = currentPage * itemsPerPage
        let endIndex = min(startIndex + itemsPerPage, viewModel.planets.count)
        if startIndex < endIndex {
            return Array(viewModel.planets[startIndex..<endIndex])
        } else {
            return []
        }
    }
}
