//
//  ActivationViewModel.swift
//  AzowoScratchCardsUI
//
//  Created by Marek Baláž on 24/07/2023.
//

import Foundation
import Combine

class ActivationViewModel: ScratchCardViewModel {
    
    // MARK: - Variables
    
    var activationService: ActivationServiceProtocol?
    var networkError = PassthroughSubject<String, Never>()
    var activationError = PassthroughSubject<String, Never>()
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Overrides
    
    convenience init(scratchCard: ScratchCard, activationService: ActivationServiceProtocol) {
        self.init(scratchCard: scratchCard)
        self.activationService = activationService
    }
    
    override func setBtn() {
        switch self.state {
        case .revealed:
            btnText = NSLocalizedString("scratch_card_navigate_activate_button", comment: "")
            btnAction = activate
            btnType = .secondaryActive
        case .activated:
            btnState = .isFinished
        default:
            ()
        }
    }
    
    override func setNavigation() {
        switch self.state {
        case .revealed:
            navigation = .none
        default:
            ()
        }
    }
    
    // MARK: - Implementation
    
    func activate() {
        
        guard let playCode = scratchCard.playCode else {
            Log.d("Missing play code.")
            return
        }

        btnState = .isLoading
        activationService?.getActivation(playCode: playCode)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }

                switch completion {
                case .failure(let error):
                    self.btnState = .normal
                    self.networkError.send(error.localizedDescription)
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] activationResponse, statusCode in
                guard let self = self else { return }

                switch statusCode {
                case 200..<300:
                    if activationResponse.status == "ok" {
                        self.scratchCard.activatedAt = Date()
                        self.state = .activated
                    } else {
                        self.btnState = .failed
                        self.activationError.send(("Activation failed. Try again later."))
                    }
                case 300..<600:
                    self.btnState = .normal
                    self.networkError.send(String(statusCode))
                default:
                    self.btnState = .normal
                    self.networkError.send("Unknown error occured.")
                }

            })
            .store(in: &cancellables)
    }
    
}
