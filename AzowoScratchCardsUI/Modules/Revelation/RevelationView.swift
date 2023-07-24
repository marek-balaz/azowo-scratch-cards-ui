//
//  RevelationView.swift
//  AzowoScratchCardsUI
//
//  Created by Marek Baláž on 24/07/2023.
//

import SwiftUI

struct RevelationView: View {
    
    @Binding var path: NavigationPath
    @Binding var state: ScratchCardState
    @ObservedObject var viewModel: RevelationViewModel
 
    var body: some View {
        ScratchCardView(path: $path, state: $state, viewModel: viewModel)
            .padding()
            .onDisappear {
                viewModel.stopRevealAnimation()
            }
    }
    
}

struct RevelationView_Previews: PreviewProvider {
    static var previews: some View {
        RevelationView(path: .constant(NavigationPath("showRevelation")), state: .constant(.revealed), viewModel: .init(scratchCard: ScratchCard(number: 8, playCode: UUID().uuidString, generatedAt: Date())))
    }
}
