//
//  StandardButtonView.swift
//  AzowoScratchCardsUI
//
//  Created by Marek Baláž on 24/07/2023.
//

import SwiftUI

enum StandardButtonStyle {
    case primaryActive
    case primaryDisabled
    case secondaryActive
    case secondaryDisabled
}

enum StandarbButtonState {
    case isLoading
    case isFinished
    case normal
    case failed
}

struct StandardButton: ButtonStyle {
    
    var backgroundColor: Color
    var borderColor: Color
    var borderWidth: CGFloat
    var titleColor: Color
    var shadowOpacity: Double
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .foregroundColor(titleColor)
            .font(Font.label())
            .cornerRadius(Design.defaultCornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: Design.defaultCornerRadius)
                    .stroke(borderColor, lineWidth: borderWidth)
            )
            .background(
                RoundedRectangle(cornerRadius: Design.defaultCornerRadius)
                    .fill(backgroundColor)
                    .shadow(color: backgroundColor.opacity(shadowOpacity), radius: 8, x: 0, y: 2)
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
    
}

struct StandardButtonView: View {
    
    @Binding public var image: Image?
    @Binding public var name: String
    @Binding public var type: StandardButtonStyle
    @Binding public var state: StandarbButtonState
    public var action: (() -> Void)?
    
    var body: some View {
        ZStack {
            Button {
                if let action = self.action {
                    action()
                }
            } label: {
                
                switch state {
                case .isLoading:
                    LoadingView()
                case .isFinished:
                    Image("check-mark")
                case .normal:
                    normalState()
                case .failed:
                    Image("cross")
                }

            }
            .frame(height: 50)
            .disabled((type == .primaryDisabled || type == .secondaryDisabled || state != .normal) ? true : false)
            .buttonStyle(custom(type))
            .transaction { transaction in
                transaction.animation = nil
            }
        }
    }
    
    private func custom(_ style: StandardButtonStyle) -> some ButtonStyle {
        switch style {
        case .primaryActive:
            return StandardButton(
                backgroundColor: Color.primary2,
                borderColor: Color.primary2,
                borderWidth: 0,
                titleColor: Color.background2,
                shadowOpacity: 0.32
            )
        case .primaryDisabled:
            return StandardButton(
                backgroundColor: Color.primary2.opacity(0.5),
                borderColor: Color.primary2.opacity(0.5),
                borderWidth: 0,
                titleColor: Color.background2,
                shadowOpacity: 0
            )
        case .secondaryActive:
            return StandardButton(
                backgroundColor: Color.background2,
                borderColor: Color.primary2,
                borderWidth: 1,
                titleColor: Color.primary2,
                shadowOpacity: 0.32
            )
        case .secondaryDisabled:
            return StandardButton(
                backgroundColor: Color.background2,
                borderColor: Color.primary2.opacity(0.5),
                borderWidth: 1,
                titleColor: Color.primary2.opacity(0.5),
                shadowOpacity: 0
            )
        }
    }
    
    @ViewBuilder
    private func normalState() -> some View {
        if let image = self.image {
            HStack {
                Text(name)
                image
            }
        } else {
            Text(name)
        }
    }
}

struct StandardButtonView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StandardButtonView(image: .constant(Image("arrow-right")), name: .constant("Standard Button"), type: .constant(.primaryActive), state: .constant(.normal), action: {})
                .previewDisplayName("Primary")
                .previewLayout(.sizeThatFits)
            StandardButtonView(image: .constant(Image("arrow-right")), name: .constant("Standard Button"), type: .constant(.primaryDisabled), state: .constant(.normal), action: {})
                .previewDisplayName("PrimaryDisabled")
                .previewLayout(.sizeThatFits)
            StandardButtonView(image: .constant(Image("arrow-right")), name: .constant("Standard Button"), type: .constant(.secondaryActive), state: .constant(.normal), action: {})
                .previewDisplayName("Secondary")
                .previewLayout(.sizeThatFits)
            StandardButtonView(image: .constant(Image("arrow-right")), name: .constant("Standard Button"), type: .constant(.secondaryDisabled), state: .constant(.normal), action: {})
                .previewDisplayName("SecondaryDisabled")
                .previewLayout(.sizeThatFits)
            StandardButtonView(image: .constant(Image("arrow-right")), name: .constant("Standard Button"), type: .constant(.primaryActive), state: .constant(.isLoading), action: {})
                .previewDisplayName("Loading")
                .previewLayout(.sizeThatFits)
            StandardButtonView(image: .constant(Image("arrow-right")), name: .constant("Standard Button"), type: .constant(.primaryActive), state: .constant(.isFinished), action: {})
                .previewDisplayName("Finished")
                .previewLayout(.sizeThatFits)
            StandardButtonView(image: .constant(Image("arrow-right")), name: .constant("Standard Button"), type: .constant(.primaryActive), state: .constant(.failed), action: {})
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Failed")
        }
        .padding()
    }
    
}
