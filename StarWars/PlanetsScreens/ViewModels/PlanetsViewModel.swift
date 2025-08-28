//
//  MovieListViewModel.swift
//  StarWars
//
//  Created by JoseAlvarez on 8/27/25.
//

import Combine
import Foundation

class PlanetsViewModel: ObservableObject {

    @Published private(set) var planets: [PlanetsModel] = []
    @Published var loadingComplete: Bool = false
    @Published var apiError: APIError?
    private var cancellables: Set<AnyCancellable> = []
    private let client: HTTPClient


    init() {
        self.client = HTTPClient()
    }

    func loadMoviesOnAppStart() {
        self.loadingComplete = false
        let starWarsPlanetsURL = StarWars(
            id: UUID(),
            endpoint: endpointEnum.planets.rawValue
        ).url.absoluteString

        client.getMethod(from: starWarsPlanetsURL, type: [PlanetsModel].self)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        self.loadingComplete = true
                    case .failure(let error):
                        self.loadingComplete = true
                        self.apiError = error
                        print("Error loading planets: \(error)")
                    }
                },
                receiveValue: { planets in
                    self.planets = planets
                }
            )
            .store(in: &cancellables)
    }
}
