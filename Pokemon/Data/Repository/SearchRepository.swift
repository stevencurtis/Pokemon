//
//  SearchRepository.swift
//  Pokemon
//
//  Created by Steven Curtis on 09/04/2021.
//

import Foundation

protocol SearchRepositoryProtocol {
    func getPokemonList(completion: @escaping (Result<[PokemonList], Error>) -> Void)
    func getPokemonDetail(url: String, completion: @escaping (Result<PokemonDetail, Error>) -> Void)
    func getCachedPokemon() -> [PokemonDetail]
}

final class SearchRepository {
    private let apiService: SearchApiServiceProtocol
    private let storageService: SearchStorageServiceProtocol
    init(
        apiService: SearchApiServiceProtocol = SearchApiService(),
        storageService: SearchStorageServiceProtocol = SearchStorageService()
    ) {
        self.apiService = apiService
        self.storageService = storageService
    }
}

extension SearchRepository: SearchRepositoryProtocol {
    
    func getCachedPokemon() -> [PokemonDetail] {
        storageService.getPokemon().map{ $0.toDomain() }
    }
    
    func getPokemonList(completion: @escaping (Result<[PokemonList], Error>) -> Void) {
        
        apiService.requestPokemonList(completion: { apiResponse in
            switch apiResponse.result {
            case .success(let dto):
                completion(.success(dto.toDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    func getPokemonDetail(url: String, completion: @escaping (Result<PokemonDetail, Error>) -> Void) {
        apiService.requestPokemonDetail(url: url, completion: { apiResponse in
            switch apiResponse.result {
            case .success(let dto):
                let storeDto = PokemonDetailStoreDto(name: dto.name, id: dto.id, images: [dto.sprites.frontDefault, dto.sprites.backDefault, dto.sprites.backFemale, dto.sprites.backShiny, dto.sprites.backShinyFemale, dto.sprites.frontFemale, dto.sprites.frontShiny, dto.sprites.frontShinyFemale].compactMap{ $0 }, stats: dto.stats.map{ PokemonDetailStoreDto.StatStoreDto(name: $0.stat.name, base: $0.baseStat) })
                self.storageService.persist(pokemon: storeDto)
                completion(.success(dto.toDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}
