//
//  FlowRunner.swift
//  Pokemon
//
//  Created by Steven Curtis on 09/04/2021.
//

import Foundation

public protocol FlowRunnerProtocol {
    func runSearchFlow(
        router: FlowRoutingServiceProtocol
    )
}

public struct FlowRunner {
    public init() {}
}

extension FlowRunner: FlowRunnerProtocol {
    public func runSearchFlow(
        router: FlowRoutingServiceProtocol
    ) {
        SearchFlow(
            router: router
        ).runFlow()
    }
}
