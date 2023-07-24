//
//  ScratchCardView.swift
//  AzowoScratchCardsUI
//
//  Created by Marek Baláž on 24/07/2023.
//

import SwiftUI

struct ScratchCardView: View {
    
    @Binding var path: NavigationPath
    @Binding var state: ScratchCardState
    @ObservedObject var viewModel: ScratchCardViewModel
    
    var body: some View {
        
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                topPart()
                middlePart()
                if viewModel.state != .activated {
                    bottomPart()
                }
            }
            .onChange(of: viewModel.state, perform: { newValue in
                state = newValue
            })
        }
        .cornerRadius(Design.defaultCornerRadius)
        .overlay {
            RoundedRectangle(cornerRadius: Design.defaultCornerRadius)
                .stroke(Color.content2, lineWidth: 1)
        }
        .background(
            RoundedRectangle(cornerRadius: Design.defaultCornerRadius)
                .fill(Color.background2)
                .shadow(color: Color.content2.opacity(0.5), radius: 8, x: 0, y: 2)
        )
    }
    
    @ViewBuilder
    func topPart() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(LocalizedStringKey(viewModel.titleText))
                    .font(Font.textAttention())
                    .foregroundColor(Color.primary2)
                ZStack {
                    RoundedRectangle(cornerRadius: Design.defaultCornerRadius)
                        .fill(Color.content)
                        .overlay(
                            RoundedRectangle(cornerRadius: Design.defaultCornerRadius)
                                .stroke(Color.content2, lineWidth: 1)
                        )
                    Text($viewModel.numberText.wrappedValue ?? "00")
                        .font(Font.textAttention())
                        .foregroundColor(Color.primary2)
                }
                .redacted(reason: (viewModel.numberText == nil) ? .placeholder : [])
                .frame(width: 40, height: 24)
            }
            Text($viewModel.stateInfoText.wrappedValue)
                .font(Font.text())
                .foregroundColor(Color.primary2)
        }
        .padding([.top, .leading, .trailing], 16)
    }
    
    @ViewBuilder
    func middlePart() -> some View {
        Divider()
            .frame(height: 1)
            .background(Color.content)
            .padding([.top, .bottom], 8)
        VStack(alignment: .leading, spacing: 8) {
            Text(LocalizedStringKey(viewModel.playCodeText))
                .font(Font.textAttention())
                .foregroundColor(Color.primary2)
            ScratchCodeView(state: $viewModel.state, progressValue: $viewModel.revealProgress, code: $viewModel.codeLblText)
        }
        .padding([.leading, .trailing], 16)
        .padding([.bottom], 12)
    }
    
    @ViewBuilder
    func bottomPart() -> some View {
        Divider()
            .frame(height: 1)
            .background(Color.content)
            .padding([.bottom], 12)
        
        StandardButtonView(image: .constant(Image("arrow-right")), name: $viewModel.btnText, type: $viewModel.btnType, state: $viewModel.btnState, action: {
            if viewModel.navigation != .none {
                path.append(viewModel.navigation.rawValue)
            } else {
                viewModel.btnAction?()
            }
        })
            .padding([.bottom, .leading, .trailing], 16)
    }
    
    func placeholderAction() {}

}

struct ScratchCardView_Previews: PreviewProvider {
    static var previews: some View {
        ScratchCardView(path: .constant(NavigationPath()), state: .constant(.revealed), viewModel: .init(scratchCard: ScratchCard(number: 12, playCode: "123", generatedAt: Date(), revealedAt: Date())))
            .padding()
            .previewLayout(.sizeThatFits)
            .previewDisplayName("Default")
    }
}
