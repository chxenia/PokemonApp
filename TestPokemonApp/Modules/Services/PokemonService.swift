//
//  PokemonService.swift
//  TestPokemonApp
//
//  Created by Xenia on 24.02.2024.
//

import Foundation

class PokemonService {
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchPokemonList(page: Int, completion: @escaping (Result<[Pokemon], Error>) -> Void) {
        guard var urlComponents = URLComponents(string: Constants.API.baseURL + Constants.API.pokemonPath) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        urlComponents.queryItems = [
            URLQueryItem(name: "offset", value: "\(20 * (page - 1))"),
            URLQueryItem(name: "limit", value: "20")
        ]
        guard let url = urlComponents.url else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        networkService.fetchData(from: url) { result in
            switch result {
            case .success(let data):
                do {
                    let decodedResponse = try JSONDecoder().decode(Response.self, from: data)
                    completion(.success(decodedResponse.results))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchPokemonDetail(url: String, completion: @escaping (Result<PokemonInfo, Error>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        networkService.fetchData(from: url) { result in
            switch result {
            case .success(let data):
                do {
                    let decodedResponse = try JSONDecoder().decode(PokemonInfo.self, from: data)
                    completion(.success(decodedResponse))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
