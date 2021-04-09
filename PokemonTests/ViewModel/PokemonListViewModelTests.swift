//
//  PokemonListViewModelTests.swift
//  PokemonTests
//
//  Created by Steven Curtis on 09/04/2021.
//

import XCTest
import Combine
@testable import Pokemon

class PokemonListViewModelTests: XCTestCase {
    var listViewModel: PokemonListViewModel!
    var searchInteractor: SearchInteractorMock!
    var searchFlow: SearchFlowMock!
    private var cancellables: Set<AnyCancellable> = []

    override func setUp() {
        super.setUp()
        cancellables = []
        searchInteractor = SearchInteractorMock()
        searchFlow = SearchFlowMock()
        listViewModel = PokemonListViewModel(searchInteractor: searchInteractor, flow: searchFlow)
    }
    
    func testNoInitialPokemon() {
        let expect = expectation(description: #function)
        var count = 0

        listViewModel.pokemonPublisher
            .receive(on: DispatchQueue.main)
            .sink {
                if count == 0 {
                    XCTAssertEqual($0, [])
                    expect.fulfill()
                }
                count += 1
            }
            .store(in: &cancellables)
        waitForExpectations(timeout: 2.0)
    }
    
    func testGivePokemon() {
        let expect = expectation(description: #function)
        listViewModel.getData()
        var count = 0
        listViewModel.pokemonPublisher
            .receive(on: DispatchQueue.main)
            .sink {
                count += 1
                if count == 2 {
                    XCTAssertEqual($0, [pokemonDetail])
                    expect.fulfill()
                }
            }
            .store(in: &cancellables)
        wait(for: [expect], timeout: 1)
    }
    
    func testGivePokemonLoaded() {
        // test that the loading indicator should start, then stop
        let expect = expectation(description: #function)
        var count = 0

        listViewModel.$shouldLoad
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {
                count += 1
                if count == 2 {
                    XCTAssertEqual($0, true)
                    expect.fulfill()
                } else {
                    XCTAssertEqual($0, false)
                }
            }
            )
            .store(in: &cancellables)
        listViewModel.getData()

        wait(for: [expect], timeout: 1)
    }
    
    func testGivePokemonError() {
        let expect = expectation(description: #function)
        
        var count = 0
        
        listViewModel.$shouldError
            .receive(on: DispatchQueue.main)
            .sink(receiveValue:{
                if count == 0 {
                    XCTAssertEqual($0, false)
                    expect.fulfill()
                }
                count += 1
            }
            )
            .store(in: &cancellables)
        listViewModel.getData()
        
        waitForExpectations(timeout: 2.0)
    }
}
