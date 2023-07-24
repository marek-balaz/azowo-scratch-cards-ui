//
//  O2API.swift
//  AzowoScratchCardsUI
//
//  Created by Marek Baláž on 24/07/2023.
//

import Foundation
import Combine

class AzowoAPI {
    
    private static let baseUrl = Const.getStringFor(key: "AzowoAPI")
    
    static func headers() -> [String: String] {
        let headers: [String: String] = [
            "Content-Type": "application/json"
        ]
        
        return headers
    }
    
    static func url(path: String, parameters: [String : String]) -> String {
        guard var urlComponents = URLComponents(string: baseUrl) else {
            fatalError("Invalid path for URL.")
        }
        urlComponents.path += "/" + path
        urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        Log.d(urlComponents.url!.absoluteString)
        return urlComponents.url!.absoluteString
    }
    
}



