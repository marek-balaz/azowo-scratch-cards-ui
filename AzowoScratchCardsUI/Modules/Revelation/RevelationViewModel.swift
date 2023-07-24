//
//  RevelationViewModel.swift
//  AzowoScratchCardsUI
//
//  Created by Marek Baláž on 24/07/2023.
//

import Foundation
import Combine

class RevelationViewModel: ScratchCardViewModel {
    
    // MARK: - Variables
    
    private var revealProgressTimer: AnyCancellable?
    private var revealRemainingDuration: Float = 0
    
    // MARK: - Constants
    
    private let revealDuration: Float = 5
    
    // MARK: - Overrides
    
    override func setBtn() {
        switch self.state {
        case .generated:
            btnText = NSLocalizedString("scratch_card_reveal_button", comment: "")
            btnAction = startRevealAnimation
            btnType = .primaryActive
        case .revealed:
            btnState = .isFinished
        default:
            ()
        }
    }
    
    override func setNavigation() {
        switch self.state {
        case .generated:
            navigation = .none
        default:
            ()
        }
    }
    
    // MARK: - Implementation
    
    private func generateUUID() -> String {
        return UUID().uuidString
    }
    
    func startRevealAnimation() {
        revealRemainingDuration = revealDuration
        btnState = .isLoading
        revealProgressTimer = Timer.publish(every: 0.01, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                if self.revealRemainingDuration <= 0 {
                    self.revealProgress = 0
                    self.revealProgressTimer?.cancel()
                    self.scratchCard.revealedAt = Date()
                    self.scratchCard.playCode = self.generateUUID()
                    self.playCode = self.scratchCard.playCode!
                    self.state = .revealed
                } else {
                    self.revealProgress = self.revealRemainingDuration / self.revealDuration
                    self.codeLblText = String(UUID().uuidString.shuffled())
                    self.revealRemainingDuration -= 0.01
                }
            }
    }
    
    func stopRevealAnimation() {
        revealProgressTimer?.cancel()
        if self.revealRemainingDuration > 0 {
            revealProgress = 1
            btnState = .normal
        }
    }
    
}
