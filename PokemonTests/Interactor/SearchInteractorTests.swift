//
//  SearchInteractorTests.swift
//  PokemonTests
//
//  Created by Steven Curtis on 09/04/2021.
//

import XCTest
@testable import Pokemon

class SearchInteractorTests: XCTestCase {

    var searchRepository: SearchRepositoryProtocol!
    var searchInteractor: SearchInteractor!
    
    override func setUpWithError() throws { }
    
    override func setUp() {
        searchRepository = SearchRepository(apiService: SearchApiServiceMock(), storageService: SearchStorageServiceMock())
        searchInteractor = SearchInteractor(searchRepository: searchRepository)
    }

    func testAllPokemon() {
        let expect = expectation(description: #function)
        searchInteractor.getPokemon(completion: {
            switch $0 {
            case .success(let detail):
                let expectedResult = Array(repeating: pokemonDetail, count: 20)
                XCTAssertEqual(detail, expectedResult)
                expect.fulfill()
            case .failure:
                XCTFail()
            }
        })
        waitForExpectations(timeout: 2.0)
    }
}
