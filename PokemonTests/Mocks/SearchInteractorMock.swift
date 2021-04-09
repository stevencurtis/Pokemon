//
//  SearchInteractorMock.swift
//  PokemonTests
//
//  Created by Steven Curtis on 09/04/2021.
//

import Foundation
@testable import Pokemon

class SearchInteractorMock: SearchInteractorProtocol {
    func getPokemon(completion: @escaping (Result<[PokemonDetail], Error>) -> Void) {
        completion(.success([pokemonDetail]))
    }
}

