//
//  PaginationTestHostView.swift
//  StarWars
//
//  Created by JoseAlvarez on 10/1/25.
//

import SwiftUI

struct PaginationTestHostView: View {
    @StateObject var planetViewModel: PlanetsViewModel
    @State private var currentPage: Int = 0
    let totalPages: Int

    var body: some View {
        VStack(spacing: 20) {
            PaginationControls(
                currentPage: $currentPage,
                totalPages: totalPages,
                pageNumbersToShow: planetViewModel.pageNumbersToShow(15, currentPage)
            )

            Text("Current page: \(currentPage + 1)")
                .accessibilityIdentifier("currentPageLabel")
        }
        .padding()
    }
}
