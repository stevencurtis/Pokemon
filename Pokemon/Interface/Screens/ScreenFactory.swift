//
//  ScreenFactory.swift
//  Pokemon
//
//  Created by Steven Curtis on 09/04/2021.
//

import UIKit

struct ScreenFactory {}

extension ScreenFactory: SearchFlowScreenFactoryProtocol {
    func makeSearchScreen(flow: SearchFlowProtocol) -> UIViewController {
        let viewModel = PokemonListViewModel(flow: flow)
        let viewController = PokemonListViewController(viewModel: viewModel)
        return viewController
    }
}
