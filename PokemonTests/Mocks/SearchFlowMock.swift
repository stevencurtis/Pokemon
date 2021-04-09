//
//  SearchFlowMock.swift
//  PokemonTests
//
//  Created by Steven Curtis on 09/04/2021.
//

import Foundation
@testable import Pokemon

class SearchFlowMock: SearchFlowProtocol {
    func runFlow() { }
    func showDetail(pokemon: PokemonDetail) { }
}
