//
//  ScratchCardViewModel.swift
//  AzowoScratchCardsUI
//
//  Created by Marek Baláž on 24/07/2023.
//

import Foundation
import Combine

enum ScratchCardState {
    case generated
    case revealed
    case activated
}

enum ScratchCardNavigation: String {
    case none
    case showRevelationView
    case showActivationView
}

class ScratchCardViewModel: ObservableObject {
    
    // MARK: - Variables
    
    @Published var scratchCard: ScratchCard
    
    @Published var numberText: String?
    @Published var state: ScratchCardState = .generated
    @Published var stateInfoText: String = "Placeholder 01.01.2023"
    @Published var btnText: String = "Scratch the card"
    @Published var btnType: StandardButtonStyle = .primaryActive
    @Published var btnState: StandarbButtonState = .normal
    @Published var btnAction: (() -> Void)?
    @Published var codeLblText: String = "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"
    @Published var playCode: String?
    @Published var revealProgress: Float = 1
    @Published var navigation: ScratchCardNavigation = .none

    let titleText = "scratch_card_title"
    let playCodeText = "scratch_card_play_code_title"
    
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Implementation
    
    init(scratchCard: ScratchCard) {
        self.scratchCard = scratchCard
        setNumberText()
        setState()
        setBtn()
        setStateInfoText()
        setNavigation()
        bind()
    }
    
    func bind() {
        $state.receive(on: DispatchQueue.main)
            .sink { [weak self] newValue in
                self?.setBtn()
                self?.setStateInfoText()
                self?.setPlayCode()
                self?.setNavigation()
            }
            .store(in: &cancellables)
    }
    
    private func setState() {
        if scratchCard.activatedAt != nil {
            state = .activated
        } else if scratchCard.revealedAt != nil {
            state = .revealed
        } else {
            state = .generated
        }
    }
    
    private func setPlayCode() {
        switch state {
        case .revealed, .activated:
            codeLblText = scratchCard.playCode!
        default:
            codeLblText = "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"
        }
    }
    
    private func setStateInfoText() {
        switch state {
        case .revealed:
            if let revealedAt = scratchCard.revealedAt {
                stateInfoText = "\(NSLocalizedString("scratch_card_subtitle_revealed", comment: "")) \(revealedAt.format())"
            } else {
                stateInfoText = "Revelation unknown."
            }
        case .activated:
            if let activatedAt = scratchCard.activatedAt {
                stateInfoText = "\(NSLocalizedString("scratch_card_subtitle_activated", comment: "")) \(activatedAt.format())"
            } else {
                stateInfoText = "Activation unknown."
            }
        default:
            stateInfoText = "\(NSLocalizedString("scratch_card_subtitle_generated", comment: "")) \(scratchCard.generatedAt!.format())"
        }
    }
    
    func setBtn() {
        switch self.state {
        case .generated:
            btnText = NSLocalizedString("scratch_card_navigate_reveal_button", comment: "")
            btnAction = nil
            btnType = .primaryActive
        case .revealed:
            btnText = NSLocalizedString("scratch_card_navigate_activate_button", comment: "")
            btnAction = nil
            btnType = .secondaryActive
        default:
            ()
        }
    }
    
    func setNavigation() {
        switch self.state {
        case .generated:
            navigation = .showRevelationView
        case .revealed:
            navigation = .showActivationView
        default:
            navigation = .none
        }
    }
    
    private func setNumberText() {
        numberText = String(scratchCard.number ?? 0)
    }
    
}
