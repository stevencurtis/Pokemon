//
//  SearchFlowScreenFactoryProtocol.swift
//  Pokemon
//
//  Created by Steven Curtis on 09/04/2021.
//

import UIKit

public protocol SearchFlowScreenFactoryProtocol {
    func makeSearchScreen(flow: SearchFlowProtocol) -> UIViewController
    func makeDetailsScreen(pokemon: PokemonDetail) -> UIViewController
}
