//
//  PokemonListViewModel.swift
//  Pokemon
//
//  Created by Steven Curtis on 09/04/2021.
//

import Foundation
import Combine

class PokemonListViewModel {
    let searchInteractor: SearchInteractorProtocol
    let flow: SearchFlowProtocol
    
    var pokemonPublisher: Published<[PokemonDetail]>.Publisher { $pokemon }
    
    @Published var keyWordSearch: String = ""
    @Published var pokemon: [PokemonDetail] = []
    @Published var shouldLoad: Bool = false
    @Published var shouldError: Bool = false
    
    var downloadedPokemon: [PokemonDetail] = []
    var cancellables: Set<AnyCancellable> = []
    
    init(
        searchInteractor: SearchInteractorProtocol = SearchInteractor(),
        flow: SearchFlowProtocol
    ) {
        self.searchInteractor = searchInteractor
        self.flow = flow
        
        $keyWordSearch.receive(on: RunLoop.main).debounce(for: .seconds(0.2), scheduler: RunLoop.main)
            .sink { keyword in
                guard keyword.count > 0 else {
                    self.pokemon = self.downloadedPokemon
                    return
                }
                self.pokemon = self.downloadedPokemon.filter{ $0.name.contains(self.keyWordSearch.lowercased()) }
            }.store(in: &cancellables)
    }
    
    func getData() {
        searchInteractor.getPokemon(completion: { result in
            self.shouldLoad = true
            switch result {
            case .success(let pokemon):
                self.downloadedPokemon = pokemon.sorted(by: {$0.name < $1.name})
                self.pokemon = self.downloadedPokemon
                self.shouldError = false
                self.shouldLoad = false
            case .failure:
                self.shouldError = true
            }
        })
    }
    
    func moveDetail(with pokemon: PokemonDetail) {
        flow.showDetail(pokemon: pokemon)
    }
}
