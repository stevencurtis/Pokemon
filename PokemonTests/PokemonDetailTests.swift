//
//  PokemonDetailTests.swift
//  PokemonTests
//
//  Created by Steven Curtis on 09/04/2021.
//

import XCTest
@testable import Pokemon

class PokemonDetailTests: XCTestCase {
    func testDecodeList() {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        XCTAssertNoThrow(try decoder.decode(PokemonDetailAPIDto.self, from: ivysaur.data(using: .utf8)!))
    }

    func testMapList() {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let dto = try? decoder.decode(PokemonDetailAPIDto.self, from: ivysaur.data(using: .utf8)!)
        XCTAssertEqual(dto!.toDomain(), pokemonDetail)
    }
}
