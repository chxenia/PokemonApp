import Foundation

class PokemonInteractor {
    func fetchPokemonList(page: Int, completion: @escaping (Result<[Pokemon], Error>) -> Void) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?offset=\(20 * (page - 1))&limit=20") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(Response.self, from: data)
                completion(.success(decodedResponse.results))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchPokemonDetail(url: String, completion: @escaping (Result<PokemonInfo, Error>) -> Void) {
        guard let url = URL(string: url) else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(PokemonInfo.self, from: data)
                completion(.success(decodedResponse))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
