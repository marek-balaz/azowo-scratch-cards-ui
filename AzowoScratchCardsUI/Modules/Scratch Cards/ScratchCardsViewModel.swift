//
//  ScratchCardsViewModel.swift
//  AzowoScratchCardsUI
//
//  Created by Marek Baláž on 24/07/2023.
//

import Foundation

class ScratchCardsViewModel: ObservableObject {
    
    @Published var cellViewModels: [ScratchCardViewModel] = []
    
    let scratchCardGeneratorService: ScratchCardGeneratorProtocol
    
    init(scratchCardGeneratorService: ScratchCardGeneratorProtocol) {
        self.scratchCardGeneratorService = scratchCardGeneratorService
        fetchData()
    }
    
    private func fetchData() {
        cellViewModels.append(ScratchCardViewModel(scratchCard: scratchCardGeneratorService.getScratchCard()))
    }
    
}
