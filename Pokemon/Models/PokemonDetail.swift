//
//  PokemonDetail.swift
//  Pokemon
//
//  Created by Steven Curtis on 09/04/2021.
//

import Foundation

struct PokemonDetailAPIDto: Decodable {
    let name: String
    let id: Int
    let sprites: Sprite
    let stats: [Stats]
    struct Sprite: Decodable {
        let frontDefault: String
        let backDefault: String
        let backFemale: String?
        let backShiny: String
        let backShinyFemale: String?
        let frontFemale: String?
        let frontShiny: String
        let frontShinyFemale: String?
    }
    struct Stats: Decodable {
        let baseStat: Int
        let effort: Int
        let stat: Stat

        struct Stat: Decodable {
            let name: String
            let url: String
        }
    }

    func toDomain() -> PokemonDetail {
        return .init(
            name: name,
            id: id,
            images: [sprites.frontDefault, sprites.backDefault, sprites.backFemale, sprites.backShiny, sprites.backShinyFemale, sprites.frontFemale, sprites.frontShiny, sprites.frontShinyFemale].compactMap { $0 },
            stats: stats.map { PokemonDetail.Stat(name: $0.stat.name, base: $0.baseStat)  }
        )
    }
}

public struct PokemonDetail: Equatable {
    let name: String
    let id: Int
    let images: [String]
    let stats: [Stat]
    struct Stat {
        let name: String
        let base: Int
    }
}

extension PokemonDetail: Hashable {}
extension PokemonDetail.Stat: Hashable {}

public struct PokemonDetailStoreDto: Codable, Equatable {
    let name: String
    let id: Int
    let images: [String]
    let stats: [StatStoreDto]
    struct StatStoreDto: Codable, Equatable {
        let name: String
        let base: Int

        func toDomain() -> PokemonDetail.Stat {
            return .init(name: name, base: base)
        }
    }

    func toDomain() -> PokemonDetail {
        return .init(
            name: name,
            id: id,
            images: images,
            stats: stats.map { $0.toDomain() }
        )
    }
}
