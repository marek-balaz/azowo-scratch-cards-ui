//
//  ScratchCardGeneratorService.swift
//  AzowoScratchCardsUI
//
//  Created by Marek Baláž on 24/07/2023.
//

import Foundation

protocol ScratchCardGeneratorProtocol: AnyObject {

    func getScratchCard() -> ScratchCard
    
}

class ScratchCardGeneratorService: ScratchCardGeneratorProtocol {
    
    func getScratchCard() -> ScratchCard {
        var index = UserDefaults.standard.integer(forKey: "number_scratch_card")
        index += 1
        UserDefaults.standard.set(index, forKey: "number_scratch_card")
        return ScratchCard(number: index, generatedAt: Date())
    }
    
}
