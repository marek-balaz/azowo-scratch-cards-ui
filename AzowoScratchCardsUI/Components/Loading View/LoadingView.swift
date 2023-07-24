//
//  LoadingView.swift
//  AzowoScratchCardsUI
//
//  Created by Marek Baláž on 24/07/2023.
//

import SwiftUI

struct LoadingView: View {
    
    @State private var isLoading = false
    
    var body: some View {
        Image("loader")
            .aspectRatio(1, contentMode: .fit)
            .rotationEffect(isLoading ? .degrees(360) : .degrees(0))
            .animation(Animation.linear(duration: 1)
                            .repeatForever(autoreverses: false), value: isLoading)
            .onAppear {
                isLoading = true
            }
            .onDisappear {
                isLoading = false
            }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
