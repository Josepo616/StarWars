//
//  StarWarsApp.swift
//  StarWars
//
//  Created by JoseAlvarez on 8/25/25.
//

import SwiftUI

@main
struct StarWarsApp: App {
    @ObservedObject private var sigInViewModel = SignInViewModel()
    @ObservedObject private var planetViewModel = PlanetsViewModel(
        planetsService: StarWarsHTTPSClient()
    )

    var body: some Scene {
        WindowGroup {
            if ProcessInfo.processInfo.environment["UITesting_ShowPagination"]
                == "1"
            {
                PaginationTestHostView(
                    planetViewModel: planetViewModel,
                    totalPages: 15
                )
            } else {
                SignInView(
                    signInViewModel: sigInViewModel,
                    planetViewModel: planetViewModel
                )
            }
        }
    }
}
