//
//  DetailViewModel.swift
//  Pokemon
//
//  Created by Steven Curtis on 09/04/2021.
//

import Foundation

class DetailViewModel {
    @Published var pokemon: PokemonDetail

    init(pokemon: PokemonDetail) {
        self.pokemon = pokemon
    }
}
