//
//  ActivationServiceProtocol.swift
//  AzowoScratchCardsUI
//
//  Created by Marek Baláž on 24/07/2023.
//

import Foundation
import Combine

protocol ActivationServiceProtocol: AnyObject {
    
    var networkService: NetworkServiceProtocol { get }
    func getActivation(playCode: String) -> AnyPublisher<(response: ActivationResponse, statusCode: Int), Error>
    
}

class ActivationService: ActivationServiceProtocol {
    
    var networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func getActivation(playCode: String) -> AnyPublisher<(response: ActivationResponse, statusCode: Int), Error> {
        return networkService.request(url: AzowoAPI.url(path: "v1/status", parameters: ["code" : playCode]), method: .get, body: nil, headers: AzowoAPI.headers())
    }
    
}
