//
//  MovieListViewModel.swift
//  StarWars
//
//  Created by JoseAlvarez on 8/27/25.
//

import Foundation
import Combine

class PlanetsViewModel: ObservableObject {
    
    @Published private(set) var planets: [PlanetsModel] = []
    private var cancellables: Set<AnyCancellable> = []
    @Published var loadingComplete: Bool = false
    
    //private let httpClient: HTTPClient
    private let httpClient_init: HTTPClient_init

    init(){
        //self.httpClient = httpClient
        self.httpClient_init = HTTPClient_init()
    }
    
   /*func searchMovies(_ search: String){
        //print("🔍 Buscando: \(search)")
        
        httpClient.fetchMovies(search: search)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    //print("movies: \(completion)")
                    //print("✅ Finalizó la búsqueda")
                    self?.loadingComplete = true
                case .failure(let error):
                    print("❌ Error al cargar películas: \(error)")
                }
            } receiveValue: { [weak self] movies in
                //print("🎬 Películas recibidas: \(movies.count)")
                self?.movies = movies
            }.store(in: &cancellables)
    }*/
    
    func loadMoviesOnAppStart() {
        self.loadingComplete = false
        
        httpClient_init.getPlanets()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.loadingComplete = true
                case .failure(let error):
                    self.loadingComplete = true
                    print("Error loading planets: \(error)")
                }
            }, receiveValue: { movies in
                self.planets = movies
            })
            .store(in: &cancellables)
    }

}
    

