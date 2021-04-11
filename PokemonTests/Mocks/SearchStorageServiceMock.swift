//
//  SearchStorageServiceMock.swift
//  PokemonTests
//
//  Created by Steven Curtis on 09/04/2021.
//

import Foundation
@testable import Pokemon

class SearchStorageServiceMock: SearchStorageServiceProtocol {
    func persist(pokemon: PokemonDetailStoreDto) { }

    func getPokemon() -> [PokemonDetailStoreDto] {
        return []
    }

}
