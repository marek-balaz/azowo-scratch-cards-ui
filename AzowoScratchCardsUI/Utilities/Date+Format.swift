//
//  Date+Format.swift
//  AzowoScratchCardsUI
//
//  Created by Marek Baláž on 24/07/2023.
//

import Foundation

extension Date {
    
    /// MMM d, yyyy, HH:mm
    func format() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.dateFormat = "MMM d, yyyy, HH:mm"
        return dateFormatter.string(from: self)
    }
    
}
