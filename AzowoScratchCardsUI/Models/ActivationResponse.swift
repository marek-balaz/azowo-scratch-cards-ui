//
//  VersionModel.swift
//  AzowoScratchCardsUI
//
//  Created by Marek Baláž on 24/07/2023.
//

import Foundation

struct ActivationResponse: Codable {
    
    let now: String
    let status: String
    let failures: [String]
    
}
