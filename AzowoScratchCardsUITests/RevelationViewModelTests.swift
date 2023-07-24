//
//  RevelationViewModelTests.swift
//  AzowoScratchCardsUITests
//
//  Created by Marek Baláž on 24/07/2023.
//

import Combine
import XCTest
@testable import AzowoScratchCardsUI

class RevelationViewModelTests: XCTestCase {

    var viewModel: RevelationViewModel!
    var cancellables: Set<AnyCancellable> = []

    override func setUp() {
        super.setUp()
        viewModel = RevelationViewModel(scratchCard: ScratchCard(number: 1, generatedAt: Date()))
    }

    func testStartRevealAnimation() {

        let expectation = self.expectation(description: "reveal animation completed")
        
        viewModel.startRevealAnimation()
        
        viewModel.$codeLblText.sink { codeLabel in
            XCTAssertNotEqual(codeLabel, UUID().uuidString)
        }.store(in: &cancellables)
        
        viewModel.$revealProgress.sink { progress in
            XCTAssertLessThanOrEqual(progress, 1)
        }.store(in: &cancellables)
        
        viewModel.$revealProgress.sink { value in
            if value > 0 {
                XCTAssertTrue(true)
            } else if value == 0 {
                expectation.fulfill()
            }
        }.store(in: &cancellables)
        
        wait(for: [expectation], timeout: 6)

        XCTAssertNotNil(viewModel.scratchCard.playCode)
    }

    func testStopRevealAnimation() {

        viewModel.startRevealAnimation()

        wait(for: [], timeout: 1)

        viewModel.stopRevealAnimation()


        let tapeProgressSubscription = viewModel.$revealProgress.sink { progress in
            XCTAssertEqual(progress, 1)
        }

        let isLoadingSubscription = viewModel.$btnState.sink { state in
            XCTAssertEqual(state, .normal)
        }

        tapeProgressSubscription.cancel()
        isLoadingSubscription.cancel()
        XCTAssertNil(viewModel.scratchCard.playCode)
    }

}
