//
//  SecondProtocol.swift
//  AIAInterviewProject
//
//  Created by Satya on 25/05/21.
//

import Foundation

protocol SecondPresenterProtocol {
    
    func fetchSymbolData(string_symbol: String)
    
    func handleErrorFromAPI()
    
}

protocol SecondViewProtocol {
    
    func processSymbolData()
}
