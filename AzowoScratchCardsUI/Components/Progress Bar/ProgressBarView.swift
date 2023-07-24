//
//  ProgressBar.swift
//  AzowoScratchCardsUI
//
//  Created by Marek Baláž on 24/07/2023.
//

import SwiftUI

struct ProgressBarView: View {
    
    @Binding var value: Float
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width, height: geometry.size.height)
                    .opacity(0.0)
                Rectangle().frame(width: min(CGFloat(value)*geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(Color.content2)
                    .animation(.linear, value: 1)
            }
            .cornerRadius(Design.defaultCornerRadius)
            .frame(height: 40)
        }
    }
}

struct ProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBarView(value: .constant(1))
            .frame(height: 40)
    }
}
