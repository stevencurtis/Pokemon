//
//  DBPokemonDetail.swift
//  Pokemon
//
//  Created by Steven Curtis on 09/04/2021.
//

import Foundation
import CoreData

@objcMembers
final class DBPokemonDetail: NSManagedObject {
    static var entityName: String {
        return "Pokemon"
    }
    @NSManaged var name: String
    @NSManaged var id: NSNumber
    @NSManaged var images: [String]
    @NSManaged var stats: Data
}

extension DBPokemonDetail {
    func toDto() -> PokemonDetailStoreDto {
        PokemonDetailStoreDto(
            name: name,
            id: id.intValue,
            images: images,
            stats:  (try? JSONDecoder().decode([PokemonDetailStoreDto.StatStoreDto].self, from: stats)) ?? []
        )
    }
    
    func update(from dto: PokemonDetailStoreDto) {
        name = dto.name
        id = NSNumber(value: dto.id)
        images = dto.images
        stats = (try? JSONEncoder().encode(dto.stats)) ?? Data()
    }
}
