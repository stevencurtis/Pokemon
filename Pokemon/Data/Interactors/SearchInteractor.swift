//
//  SearchInteractor.swift
//  Pokemon
//
//  Created by Steven Curtis on 09/04/2021.
//

import Foundation

protocol SearchInteractorProtocol {
    func getPokemon(completion: @escaping (Result<[PokemonDetail], Error>) -> Void)
    
}

class SearchInteractor {
    private let searchRepository: SearchRepositoryProtocol
    
    init(
        searchRepository: SearchRepositoryProtocol = SearchRepository()
    ) {
        self.searchRepository = searchRepository
    }
}

extension SearchInteractor: SearchInteractorProtocol {
    func getPokemon(completion: @escaping (Result<[PokemonDetail], Error>) -> Void) {
        
        let dispatchGroup = DispatchGroup()
        var pokemonArray: [PokemonDetail] = []
        
        let cachedPokemon = searchRepository.getCachedPokemon()
        if !cachedPokemon.isEmpty {
            completion(.success(cachedPokemon))
        } else {
            searchRepository.getPokemonList(completion: { result in
                switch result {
                case .success(let pokemonList):
                    for pokemon in pokemonList {
                        dispatchGroup.enter()
                        self.searchRepository.getPokemonDetail(url: pokemon.url, completion: { detailResult in
                            switch detailResult {
                            case .success(let detail):
                                pokemonArray.append(detail)
                                dispatchGroup.leave()
                            case .failure:
                                break
                            }
                        })
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
                
                dispatchGroup.notify(queue: .main, execute: {
                    completion(.success(pokemonArray))
                })
            }
            )
        }
        
    }
}
