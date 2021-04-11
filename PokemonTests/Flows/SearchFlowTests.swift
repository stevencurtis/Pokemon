//
//  SearchFlowTests.swift
//  PokemonTests
//
//  Created by Steven Curtis on 09/04/2021.
//

import XCTest
@testable import Pokemon

class SearchFlowTests: XCTestCase {
    var router: FlowRoutingServiceProtocol!
    var screenFactory: SearchFlowScreenFactoryProtocol!
    var flowRunner: FlowRunnerProtocol!
    var searchFlow: SearchFlow!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func setUp() {
        router = FlowRoutingServiceMock()
        screenFactory = SearchFlowScreenFactoryMock()
        flowRunner = FlowRunnerMock()
        searchFlow = SearchFlow(router: router, screenFactory: screenFactory, flowRunner: flowRunner)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testRunFlow() {
        searchFlow.runFlow()
        XCTAssertEqual((router as! FlowRoutingServiceMocked).pushed, true)
        XCTAssertEqual((screenFactory as! SearchFlowScreenFactoryMocked).madeSearchScreen, true)
        XCTAssertEqual((screenFactory as! SearchFlowScreenFactoryMocked).madeDetailScreen, false)
    }

    func testShowDetails() {
        searchFlow.showDetail(pokemon: pokemonDetail)
        XCTAssertEqual((router as! FlowRoutingServiceMocked).pushed, true)
        XCTAssertEqual((screenFactory as! SearchFlowScreenFactoryMocked).madeSearchScreen, false)
        XCTAssertEqual((screenFactory as! SearchFlowScreenFactoryMocked).madeDetailScreen, true)
    }
}
