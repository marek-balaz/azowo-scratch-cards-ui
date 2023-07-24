//
//  ScratchCodeView.swift
//  AzowoScratchCardsUI
//
//  Created by Marek Baláž on 24/07/2023.
//

import SwiftUI

struct ScratchCodeView: View {
    
    @Binding var state: ScratchCardState
    @Binding var progressValue: Float
    @Binding var code: String
    
    var body: some View {
        ZStack {
            Text(code)
                .font(Font.textDetail())
                .frame(height: 40)
                .frame(maxWidth: .infinity)
                .foregroundColor(Color.primary2)
                .background(
                    RoundedRectangle(cornerRadius: Design.defaultCornerRadius)
                        .fill(Color.content)
                )
            if state == .generated {
                ProgressBarView(value: $progressValue)
            }
        }
        .frame(height: 40)
    }
    
}

struct ScratchCodeView_Previews: PreviewProvider {
    static var previews: some View {
        ScratchCodeView(state: .constant(.revealed), progressValue: .constant(0.45), code: .constant("XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
