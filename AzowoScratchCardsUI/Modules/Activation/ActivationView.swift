//
//  ActivationView.swift
//  AzowoScratchCardsUI
//
//  Created by Marek Baláž on 24/07/2023.
//

import SwiftUI
import Combine

struct ActivationView: View {
    
    @State var toastMsg: String?
    @Binding var path: NavigationPath
    @Binding var state: ScratchCardState

    @ObservedObject var viewModel: ActivationViewModel
    
    var body: some View {
        ZStack {
            ScratchCardView(path: $path, state: $state, viewModel: viewModel)
                .padding()
                .onReceive(viewModel.activationError) { errorMsg in
                    toastMsg = errorMsg
                }
            
            if toastMsg != nil {
                withAnimation {
                    ToastView(message: $toastMsg)
                        .transition(.move(edge: .bottom))
                        .onAppear{
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation {
                                    toastMsg = nil
                                }
                            }
                        }
                }
            }
        }
        .animation(.easeInOut(duration: 0.5), value: (toastMsg?.isEmpty ?? true) ? false : true)
    }
    
}

struct ActivationView_Previews: PreviewProvider {
    static var previews: some View {
        ActivationView(toastMsg: "Error", path: .constant(NavigationPath("showActivation")), state: .constant(.generated), viewModel: .init(scratchCard: ScratchCard(number: 8, playCode: UUID().uuidString, generatedAt: Date(), revealedAt: Date())))
    }
}
