//
//  ActivationServiceMock.swift
//  AzowoScratchCardsUITests
//
//  Created by Marek Baláž on 24/07/2023.
//

import Combine
import XCTest
@testable import AzowoScratchCardsUI

class ActivationServiceMock: ActivationServiceProtocol {
    
    var networkService: NetworkServiceProtocol = NetworkService()
    
    let activationResponse: ActivationResponse
    let statusCode: Int
    let error: Error?
    
    init(activationResponse: ActivationResponse, statusCode: Int, error: Error? = nil) {
        self.activationResponse = activationResponse
        self.statusCode = statusCode
        self.error = error
    }
    
    func getActivation(playCode: String) -> AnyPublisher<(response: ActivationResponse, statusCode: Int), Error> {
        if let error = error {
            return Fail(error: error).eraseToAnyPublisher()
        } else {
            return Just((response: activationResponse, statusCode: statusCode))
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
    
}
