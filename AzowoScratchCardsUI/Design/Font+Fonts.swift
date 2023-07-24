//
//  Fonts.swift
//  AzowoScratchCardsUI
//
//  Created by Marek Baláž on 24/07/2023.
//

import SwiftUI

extension Font {
    // H1
    static func h1() -> Font {
        return Font.custom("Kanit-Bold", size: 24)
    }
    
    // Text
    static func text() -> Font {
        return Font.custom("Kanit-Regular", size: 16)
    }
    
    // Text-attention
    static func textAttention() -> Font {
        return Font.custom("Kanit-Bold", size: 16)
    }
    
    // Label
    static func label() -> Font {
        return Font.custom("Kanit-Medium", size: 14)
    }
    
    static func textDetail() -> Font {
        return Font.custom("Kanit-Regular", size: 12)
    }
}
