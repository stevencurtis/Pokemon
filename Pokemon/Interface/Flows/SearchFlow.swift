//
//  SearchFlow.swift
//  Pokemon
//
//  Created by Steven Curtis on 09/04/2021.
//

import Foundation

public protocol SearchFlowProtocol {
    func runFlow()
    func showDetail(pokemon: PokemonDetail)
}

extension SearchFlowProtocol { }

final class SearchFlow {
    private let router: FlowRoutingServiceProtocol
    private let screenFactory: SearchFlowScreenFactoryProtocol
    private let flowRunner: FlowRunnerProtocol
    
    init(
        router: FlowRoutingServiceProtocol,
        screenFactory: SearchFlowScreenFactoryProtocol = ScreenFactory(),
        flowRunner: FlowRunnerProtocol = FlowRunner()
    ) {
        self.router = router
        self.screenFactory = screenFactory
        self.flowRunner = flowRunner
    }
}

extension SearchFlow: SearchFlowProtocol {
    func runFlow() {
        showListScreen()
    }
    
    private func showListScreen() {
        router.showPushed(
            screenFactory.makeSearchScreen(flow: self)
        )
    }
    
    func showDetail(pokemon: PokemonDetail) {
        router.showPushed(screenFactory.makeDetailsScreen(pokemon: pokemon))
    }
}
