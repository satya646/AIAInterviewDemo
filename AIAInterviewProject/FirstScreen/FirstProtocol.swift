//
//  FirstProtocol.swift
//  AIAInterviewProject
//
//  Created by Satya on 24/05/21.
//

import Foundation

protocol FirstPresenterProtocol {
    
    func searchSymbol(string_symbol: String)
    
    func fetchSymbolData(string_symbol: String)
    
    func handleErrorFromAPI()
    
}

protocol FirstViewProtocol {
    
    func processSearchResults()
    
    func processSymbolIntraData()
}
