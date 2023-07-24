//
//  ScratchCard.swift
//  AzowoScratchCardsUI
//
//  Created by Marek Baláž on 24/07/2023.
//

import Foundation

class ScratchCard: Codable {

    var number: Int?
    var playCode: String?
    var generatedAt: Date?
    var revealedAt: Date?
    var activatedAt: Date?
    
    init(number: Int? = nil, playCode: String? = nil, generatedAt: Date? = nil, revealedAt: Date? = nil, activatedAt: Date? = nil) {
        self.number = number
        self.playCode = playCode
        self.generatedAt = generatedAt
        self.revealedAt = revealedAt
        self.activatedAt = activatedAt
    }
    
}
