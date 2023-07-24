//
//  ContentView.swift
//  AzowoScratchCardsUI
//
//  Created by Marek Baláž on 24/07/2023.
//

import SwiftUI

struct ScratchCardsView: View {
    
    @StateObject var viewModel: ScratchCardsViewModel = ScratchCardsViewModel(scratchCardGeneratorService: ScratchCardGeneratorService())
    @State private var path = NavigationPath()

    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .font : UIFont.init(name: "Kanit-Bold", size: 24)!,
            .foregroundColor : UIColor(named: "primary")!]
        UINavigationBar.appearance().titleTextAttributes = [
            .font : UIFont.init(name: "Kanit-Bold", size: 16)!,
            .foregroundColor : UIColor(named: "primary")!]
    }
    
    var body: some View {
        
        NavigationStack(path: $path) {
            List {
                ForEach($viewModel.cellViewModels, id: \.scratchCard.number) { $scratchCardModel in
                    ScratchCardView(path: $path, state: $scratchCardModel.state, viewModel: scratchCardModel)
                    .navigationDestination(for: String.self) { value in
                        switch ScratchCardNavigation(rawValue: value) {
                        case .showRevelationView:
                            RevelationView(path: $path, state: $scratchCardModel.state, viewModel: RevelationViewModel(scratchCard: scratchCardModel.scratchCard))
                        case .showActivationView:
                            ActivationView(path: $path, state: $scratchCardModel.state, viewModel: ActivationViewModel(scratchCard: scratchCardModel.scratchCard, activationService: ActivationService(networkService: NetworkService())))
                        case .some(.none), nil:
                            EmptyView()
                        }
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets())
                    .padding([.leading, .trailing])
                    .padding([.top, .bottom], 8)
                }
            }
            .listStyle(.plain)
            .navigationTitle("My Scratch Cards")
        }
        
    }
}

struct ScratchCardsView_Previews: PreviewProvider {
    static var previews: some View {
        ScratchCardsView()
    }
}
