//
//  SymbolSearchResult.swift
//  AIAInterviewProject
//
//  Created by Satya on 24/05/21.
//

import Foundation

struct SymbolSearchResult: Codable {
    
    let bestMatches: [SymbolData]?
}

struct SymbolData: Codable {
    
    let symbol: String?
    let name: String?
    
    private enum CodingKeys: String, CodingKey {
        case symbol = "1. symbol"
        case name = "2. name"
    }
}
