//
//  DetailViewModelTests.swift
//  PokemonTests
//
//  Created by Steven Curtis on 09/04/2021.
//

import XCTest
import Combine
@testable import Pokemon

class DetailViewModelTests: XCTestCase {
    var detailViewModel: DetailViewModel!
    private var cancellables: Set<AnyCancellable> = []

    override func setUpWithError() throws {
        detailViewModel = DetailViewModel(pokemon: pokemonDetail)
    }
    
    func testupdatePublisher() {
        let expect = expectation(description: #function)
        
        detailViewModel.$pokemon
            .sink {
                XCTAssertEqual($0, pokemonDetail)
                expect.fulfill()
            }
            .store(in: &cancellables)
        waitForExpectations(timeout: 2.0)
    }
}
