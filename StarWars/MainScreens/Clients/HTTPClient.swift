//
//  HTTPClient.swift
//  StarWars
//
//  Created by JoseAlvarez on 8/27/25.
//
import Foundation
import Combine


extension String {
    var urlEncoded: String? {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
}


enum NetworkError: Error {
    case badUrl
    
}

/*
public struct HTTPClient {
    func fetchMovies(search: String) -> AnyPublisher<[PlanetsModel], Error> {
        guard let encodeSearch = search.urlEncoded,
              let url = URL(string: "https://www.omdbapi.com/?s=\(encodeSearch)&apikey=ec7674ec")
        else {
            return Fail(error: NetworkError.badUrl).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: MoviesResponse.self, decoder: JSONDecoder())
            .map { response in
                if response.Response == "True" {
                    return response.Search ?? []
                } else {
                    return []
                }
            }

            .receive(on: DispatchQueue.main)
            .catch { error -> AnyPublisher<[PlanetsModel], Error> in
                return Just([]).setFailureType(to: Error.self).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
 */

// MARK: - for automatic load when launch app

public struct HTTPClient_init {
    func getPlanets() -> AnyPublisher<[PlanetsModel], Error> {
        guard let url = URL(string: "https://swapi.info/api/planets/") else {
            print("Error: URL is not valid.")
            return Fail(error: NetworkError.badUrl).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { response in
                print("Response: \(response.response)")
                return response.data
            }
            .decode(type: [PlanetsModel].self, decoder: JSONDecoder())
            .map { response in
                print("Decoded data: \(response)")
                return response
            }
            .receive(on: DispatchQueue.main)
            .catch { error -> AnyPublisher<[PlanetsModel], Error> in
                print("Error in the petition: \(error)")
                return Just([]).setFailureType(to: Error.self).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}


