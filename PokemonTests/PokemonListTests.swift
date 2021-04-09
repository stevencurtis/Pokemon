//
//  PokemonListTests.swift
//  PokemonTests
//
//  Created by Steven Curtis on 09/04/2021.
//

import XCTest
@testable import Pokemon

class PokemonListTests: XCTestCase {
    func testDecodeList() {
        XCTAssertNoThrow(try JSONDecoder().decode(PokemonListAPIDto.self, from: pokeList.data(using: .utf8)!))
    }
    
    func testMapList() {
        let dto = try? JSONDecoder().decode(PokemonListAPIDto.self, from: pokeList.data(using: .utf8)!)
        XCTAssertEqual(dto?.toDomain(), pokemonList)
    }
}
