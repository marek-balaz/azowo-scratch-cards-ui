//
//  ScratchCardsViewModelTests.swift
//  AzowoScratchCardsUITests
//
//  Created by Marek Baláž on 24/07/2023.
//

import XCTest
@testable import AzowoScratchCardsUI

class ScratchCardsViewModelTests: XCTestCase {

    var viewModel: ScratchCardsViewModel!
    var generatorService: ScratchCardGeneratorService!
    
    override func setUp() {
        super.setUp()
        generatorService = ScratchCardGeneratorService()
        viewModel = ScratchCardsViewModel(scratchCardGeneratorService: generatorService)
    }

    override func tearDown() {
        generatorService = nil
        viewModel = nil
        super.tearDown()
    }

    func testFetchDataOnViewModelInit() {
        XCTAssertEqual(viewModel.cellViewModels.count, 1)
        XCTAssertNil(viewModel.cellViewModels.first?.playCode)
    }

}
