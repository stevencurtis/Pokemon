//
//  SearchApiServiceMock.swift
//  PokemonTests
//
//  Created by Steven Curtis on 09/04/2021.
//

import Foundation
@testable import Pokemon

class SearchApiServiceMock: SearchApiServiceProtocol {
    func requestPokemonList(completion: @escaping (ApiResponse<PokemonListAPIDto>) -> Void) {
        let dto = (try? JSONDecoder().decode(PokemonListAPIDto.self, from: pokeList.data(using: .utf8)!))!
        completion(.success(.init(), dto))
    }
    
    func requestPokemonDetail(url: String, completion: @escaping (ApiResponse<PokemonDetailAPIDto>) -> Void) {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let dto = (try? decoder.decode(PokemonDetailAPIDto.self, from: ivysaur.data(using: .utf8)!))!
        completion(.success(.init(), dto))
    }
}

