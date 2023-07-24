//
//  ActivationViewModelTests.swift
//  AzowoScratchCardsUITests
//
//  Created by Marek Baláž on 24/07/2023.
//

import Combine
import XCTest
@testable import AzowoScratchCardsUI

class ActivationViewModelTests: XCTestCase {
    
    var activationServiceMock: ActivationServiceMock!
    var viewModel: ActivationViewModel!
    var cancellables: Set<AnyCancellable> = []
    
    func testActivateValidStatus() {
        
        activationServiceMock = ActivationServiceMock(activationResponse: ActivationResponse(now: "2023-07-23T07:41:24+00:00", status: "ok", failures: []), statusCode: 200)
        viewModel = ActivationViewModel(scratchCard: ScratchCard(number: 1, playCode: "123", generatedAt: Date(), revealedAt: Date()), activationService: activationServiceMock)
        
        let expectation = XCTestExpectation(description: "Activation succeeded")
        
        viewModel.activationService?.getActivation(playCode: "123")
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                ()
            }, receiveValue: { activationResponse, statusCode in
                expectation.fulfill()
            })
            .store(in: &cancellables)
    
        viewModel.activate()

        wait(for: [expectation], timeout: 1.0)
        XCTAssertNotNil(viewModel.scratchCard.activatedAt)
        XCTAssertEqual(viewModel.state, .activated)
    }
    
    func testActivateInvalidStatus() {
        
        activationServiceMock = ActivationServiceMock(activationResponse: ActivationResponse(now: "2023-07-23T07:41:24+00:00", status: "no_ok", failures: []), statusCode: 200)
        viewModel = ActivationViewModel(scratchCard: ScratchCard(number: 1, playCode: "123", generatedAt: Date(), revealedAt: Date()), activationService: activationServiceMock)
        
        let expectation = XCTestExpectation(description: "Activation failed")
        
        viewModel.activationService?.getActivation(playCode: "123")
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                ()
            }, receiveValue: { activationResponse, statusCode in
                expectation.fulfill()
            })
            .store(in: &cancellables)
    
        viewModel.activate()

        wait(for: [expectation], timeout: 1.0)
        XCTAssertNil(viewModel.scratchCard.activatedAt)
        XCTAssertEqual(viewModel.state, .revealed)
    }
    
}
