//
//  SearchFlowScreenFactoryMock.swift
//  PokemonTests
//
//  Created by Steven Curtis on 09/04/2021.
//

import UIKit
@testable import Pokemon

class SearchFlowScreenFactoryMock: SearchFlowScreenFactoryProtocol {
    var madeSearchScreen: Bool = false
    var madeDetailScreen: Bool = false
    func makeSearchScreen(flow: SearchFlowProtocol) -> UIViewController {
        madeSearchScreen = true
        return UIViewController()
    }
    
    func makeDetailsScreen(pokemon: PokemonDetail) -> UIViewController {
        madeDetailScreen = true
        return UIViewController()
    }
}

protocol SearchFlowScreenFactoryMocked {
    var madeSearchScreen: Bool { get }
    var madeDetailScreen: Bool { get }
}

extension SearchFlowScreenFactoryMock: SearchFlowScreenFactoryMocked{}

