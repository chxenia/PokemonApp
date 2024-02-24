//
//  NetworkService.swift
//  TestPokemonApp
//
//  Created by Xenia on 24.02.2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case networkError(Error)
}

class NetworkService {
    func fetchData(from url: URL, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.invalidURL))
                return
            }
            
            if let data = data {
                completion(.success(data))
            }
        }.resume()
    }
}

