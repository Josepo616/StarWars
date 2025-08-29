//
//  PlanetListView.swift
//  StarWars
//
//  Created by JoseAlvarez on 8/28/25.
//

import SwiftUI

struct PlanetListView: View {
    
    @StateObject var viewModel: PlanetsViewModel
    @State private var currentPage: Int = 0
    private let itemsPerPage: Int = 4
    
    var body: some View {
        VStack {
            PlanetListContent(
                planets: viewModel.currentPageItems(currentPage, itemsPerPage)
            )
            
            Spacer()
            
            PaginationControls(
                currentPage: $currentPage,
                totalPages: viewModel.totalPages(itemsPerPage),
                pageNumbersToShow: viewModel.pageNumbersToShow(viewModel.totalPages(itemsPerPage), currentPage)
            )
        }
        .padding()
    }
}


