//
//  SearchAPIService.swift
//  Pokemon
//
//  Created by Steven Curtis on 09/04/2021.
//

import Foundation
import NetworkLibrary

protocol SearchApiServiceProtocol {
    func requestPokemonList(completion: @escaping (ApiResponse<PokemonListAPIDto>) -> Void)
    func requestPokemonDetail(url: String, completion: @escaping (ApiResponse<PokemonDetailAPIDto>) -> Void)
}

final class SearchApiService {
    private var anyNetworkManager: AnyNetworkManager<URLSession>?

    init() {
        self.anyNetworkManager = AnyNetworkManager()
    }

    init<T: NetworkManagerProtocol> (
        networkManager: T
    ) {
        self.anyNetworkManager = AnyNetworkManager(manager: networkManager)
    }
}

extension SearchApiService: SearchApiServiceProtocol {
    func requestPokemonList(completion: @escaping (ApiResponse<PokemonListAPIDto>) -> Void) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/") else {
            completion(.failure(.init(), .generic))
            return
        }
        anyNetworkManager?.fetch(url: url, method: .get(headers: [:]), completionBlock: {result in
            if let res = try? result.get() {
                let decoder = JSONDecoder()
                if let decoded = try? decoder.decode(PokemonListAPIDto.self, from: res) {
                    completion(.success(.init(), decoded))
                } else {
                    completion(.failure(.init(), .generic))
                }
            } else {
                completion(.failure(.init(), .generic))
            }
        }
        )
    }

    func requestPokemonDetail(url: String, completion: @escaping (ApiResponse<PokemonDetailAPIDto>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.init(), .generic))
            return
        }
        anyNetworkManager?.fetch(url: url, method: .get(headers: [:]), completionBlock: {result in
            if let res = try? result.get() {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                if let decoded = try? decoder.decode(PokemonDetailAPIDto.self, from: res) {
                    completion(.success(.init(), decoded))
                } else {
                    completion(.failure(.init(), .generic))
                }
            } else {
                completion(.failure(.init(), .generic))
            }
        }
        )
    }
}
