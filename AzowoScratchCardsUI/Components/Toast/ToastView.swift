//
//  ToastView.swift
//  AzowoScratchCardsUI
//
//  Created by Marek Baláž on 24/07/2023.
//

import SwiftUI

struct ToastView: View {
    
    @Binding var message: String?
    
    var body: some View {
        if let message = self.message {

            HStack(alignment: .top) {
                Image("info-bubble")
                    .frame(width: 24, height: 24, alignment: .top)
                Text(message)
                    .font(Font.text())
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
            .foregroundColor(Color.primary2)
            .background(
                ZStack {
                    Rectangle()
                        .fill()
                        .cornerRadius(Design.defaultCornerRadius)
                        .foregroundColor(Color.background)
                    RoundedRectangle(cornerRadius: Design.defaultCornerRadius)
                        .stroke(Color.content2, lineWidth: 1)
                        .foregroundColor(.none)
                }
            )
            .padding()
            .frame(maxHeight: .infinity, alignment: .bottom)
        }
    }
}

struct ToastView_Previews: PreviewProvider {
    static var previews: some View {
        ToastView(message: .constant("This is verdads  asdda asd adas dafd fsdf sdfs fsffsdjhfbsf sfsfjhsf sfshf sf ada sdadajda dadasda d ads adsad asd asd ad asdasda dadhadg a adh ad "))
    }
}
