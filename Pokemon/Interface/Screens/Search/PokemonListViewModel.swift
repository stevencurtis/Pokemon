//
//  PokemonListViewModel.swift
//  Pokemon
//
//  Created by Steven Curtis on 09/04/2021.
//

import Foundation

class PokemonListViewModel {
    let searchInteractor: SearchInteractorProtocol
    let flow: SearchFlowProtocol

    init(
        searchInteractor: SearchInteractorProtocol = SearchInteractor(),
        flow: SearchFlowProtocol
    ) {
        self.searchInteractor = searchInteractor
        self.flow = flow
    }
    
    func getData() {
        searchInteractor.getPokemon(completion: { result in
            switch result {
            case .success(let pokemon):
                print("Succesfully returned \(pokemon.count): \(pokemon)")
            case .failure(let error):
//                print("Failed to return Pokemon\(error)")
            break
            }
        })
    }
    
}
