//
//  SearchStorageService.swift
//  Pokemon
//
//  Created by Steven Curtis on 09/04/2021.
//

import Foundation

protocol SearchStorageServiceProtocol {
    func persist(pokemon: PokemonDetailStoreDto)
    func getPokemon() -> [PokemonDetailStoreDto]
}

final class SearchStorageService {
    private let dataManager: DataManager
    
    init(dataManager: DataManager = DataManager()) {
        self.dataManager = dataManager
    }
}

extension SearchStorageService: SearchStorageServiceProtocol {
    func getPokemon() -> [PokemonDetailStoreDto] {
        let pokemon = try? dataManager.getPokemon()
        return pokemon ?? []
    }
    
    func persist(pokemon: PokemonDetailStoreDto) {
        dataManager.save(pokemon: pokemon)
    }
    
}
