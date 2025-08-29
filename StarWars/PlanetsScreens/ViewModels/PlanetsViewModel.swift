//
//  PlanetsViewModel.swift
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
    private var planetsService: PlanetsService

    init(planetsService: PlanetsService) {
        self.planetsService = planetsService
    }

    // MARK: - Funcs to interact with API
    func loadPlanetsOnStart() {
        self.loadingComplete = false
        let starWarsPlanetsURL = StarWars(
            id: UUID(),
            endpoint: endpointEnum.planets.rawValue
        ).url.absoluteString

        planetsService.fetchPlanets(from: starWarsPlanetsURL)
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

    // MARK: - view helpers

    func totalPages(_ itemsPerPage: Int) -> Int {
        max(1, Int(ceil(Double(self.planets.count) / Double(itemsPerPage))))
    }

    func pageNumbersToShow(_ totalPages: Int, _ currentPage: Int) -> [Int] {
        var pagesToShow: [Int] = []
        let startPage = max(1, currentPage - 2)
        let endPage = min(totalPages - 2, currentPage + 2)

        pagesToShow = Array(startPage...endPage)

        if currentPage > 2 {
            if pagesToShow.first != 0 {
                pagesToShow.insert(-1, at: 0)
            }
        }

        if pagesToShow.last != totalPages - 3 {
            pagesToShow.append(-1)
        }

        return pagesToShow
    }

    func currentPageItems(_ currentPage: Int, _ itemsPerPage: Int)
        -> [PlanetsModel]
    {
        let startIndex = currentPage * itemsPerPage
        let endIndex = min(startIndex + itemsPerPage, self.planets.count)
        return startIndex < endIndex
            ? Array(self.planets[startIndex..<endIndex]) : []
    }

}
