//
//  SecondPresenter.swift
//  AIAInterviewProject
//
//  Created by Satya on 25/05/21.
//

import Foundation

import UIKit

class SecondPresenter: SecondPresenterProtocol {
    
    //Properties
    var second_viewController: SecondViewController? = nil
    
    var symbol_search_results: SymbolSearchResult?
    
    var intraDataOne: [IntraData]?
    var intraDataTwo: [IntraData]?
    var intraDataThree: [IntraData]?
    
    //MARK: - Initaliser Method
    required init(view: SecondViewController) {
        
        self.second_viewController = view
        
        intraDataOne = [IntraData]()
        intraDataTwo = [IntraData]()
        intraDataThree = [IntraData]()
        
    }
    
    //MARK: - API Moethods
    
    func searchSymbol(string_symbol: String) {
        
        let headers = [ACCEPT : APPLICATION_JSON]
        let params_ = ["keywords":string_symbol,"apikey":AIAShare.shared.API_KEY ?? "1PHVIS1IU11QEF14"]
        
        _ = NetworkInterface.getRequest(.SYMBOL_SEARCH, headers: headers as NSDictionary, params: params_ as NSDictionary, requestCompletionHander: { (success, data, response, error, header) -> (Void)in
            
            if success{
                
                do
                {
                    if let json_from_server = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {

                        print("JSON: \(json_from_server)")
                    }
                    
                    let decoder = JSONDecoder()
                    let symbolData = try decoder.decode(SymbolSearchResult.self, from: data!)
                    self.processSearchDataAndPassToViews(symbol_search_data_: symbolData)
                }
                catch{
                    print("AirPort model codable error: \(error)")
                    self.handleErrorFromAPI()
                }
            }
            else{
                //Handle API fetching failure case
                self.handleErrorFromAPI()
            }
        })
    }
    
    func fetchSymbolData(string_symbol: String) {
        
        let headers = [ACCEPT : APPLICATION_JSON]
        
        let params_ = ["symbol":string_symbol, "apikey":AIAShare.shared.API_KEY ?? "1PHVIS1IU11QEF14"]
        
        second_viewController?.showActivityIndicator()
        
        _ = NetworkInterface.getRequest(.TIME_SERIES_DAILY_ADJUSTED, headers: headers as NSDictionary, params: params_ as NSDictionary, requestCompletionHander: { (success, data, response, error, header) -> (Void)in
            
            DispatchQueue.main.async {
                self.second_viewController?.stopActivityIndicator()
            }
            
            if success{
                
                do{
                    
                    //Tried DynamicCoding key but couldn't achive it successfully.
                    
//                    let decoder = JSONDecoder()
//                    let symbolData = try decoder.decode(IntraData.self, from: data!)
//                    let symbolData = try decoder.decode(DecodedArray.self, from: data!)
//                    print("symbolData: \(symbolData)")
//                    self.processSymbolDataAndPasstoView(symbol_data_: symbolData)
                    
                    if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                        
                        self.processSymbolData(symbolData_: json as NSDictionary)
                    }
                }
                catch{
                    print("AirPort model codable error: \(error)")
                    self.handleErrorFromAPI()
                }
            }
            else{
                //Handle API fetching failure case
                self.handleErrorFromAPI()
            }
        })
    }
    
    func handleErrorFromAPI() {
        
    }
    
    //MARK: - Processing fetched data
    
    func processSearchDataAndPassToViews(symbol_search_data_: SymbolSearchResult){
        
        if let best_matches_ = symbol_search_data_.bestMatches{
            
            if best_matches_.count > 0{
                
                //Passing data to presenter to access in Views
                symbol_search_results = symbol_search_data_
                
                DispatchQueue.main.async {
                    self.second_viewController?.processSearchResults()
                }
            }
        }
    }
    
    func processSymbolData(symbolData_: NSDictionary){
        
        let _symbolData = symbolData_["Time Series (Daily)"] as? NSDictionary
        let metaData = symbolData_["Meta Data"] as? NSDictionary
        let symbol_name = metaData?.value(forKey: "2. Symbol") as? String
        
        if let symbolData = _symbolData{
        
            if symbolData.allKeys.count == 0{
                second_viewController?.showNotFoundAlert(string_name: symbol_name!)
            }
            
            if intraDataOne!.count == 0{
                
                for key_timeSeries in symbolData.allKeys{
                    
                    let dictSymbol = symbolData.value(forKey: key_timeSeries as! String) as! NSDictionary
                    
                    var symbolInformation = SymbolInformation()
                    symbolInformation.open = dictSymbol.value(forKey: "1. open") as? String
                    symbolInformation.high = dictSymbol.value(forKey: "2. high") as? String
                    symbolInformation.low = dictSymbol.value(forKey: "3. low") as? String
                    
                    let single_timeSeries = IntraData(timeSeriesKey: key_timeSeries as? String, timeSeriesValue: symbolInformation, name: symbol_name)
                    intraDataOne?.append(single_timeSeries)
                }
            }
            else if intraDataTwo!.count == 0{
                
                for key_timeSeries in symbolData.allKeys{
                    
                    let dictSymbol = symbolData.value(forKey: key_timeSeries as! String) as! NSDictionary
                    
                    var symbolInformation = SymbolInformation()
                    symbolInformation.open = dictSymbol.value(forKey: "1. open") as? String
                    symbolInformation.high = dictSymbol.value(forKey: "2. high") as? String
                    symbolInformation.low = dictSymbol.value(forKey: "3. low") as? String
                    
                    let single_timeSeries = IntraData(timeSeriesKey: key_timeSeries as? String, timeSeriesValue: symbolInformation, name: symbol_name)
                    intraDataTwo?.append(single_timeSeries)
                }
                
            }
            else if intraDataThree!.count == 0{
                
                for key_timeSeries in symbolData.allKeys{
                    
                    let dictSymbol = symbolData.value(forKey: key_timeSeries as! String) as! NSDictionary
                    
                    var symbolInformation = SymbolInformation()
                    symbolInformation.open = dictSymbol.value(forKey: "1. open") as? String
                    symbolInformation.high = dictSymbol.value(forKey: "2. high") as? String
                    symbolInformation.low = dictSymbol.value(forKey: "3. low") as? String
                    
                    let single_timeSeries = IntraData(timeSeriesKey: key_timeSeries as? String, timeSeriesValue: symbolInformation, name: symbol_name)
                    intraDataThree?.append(single_timeSeries)
                }
            }
            else{
                //Search limit reached
                second_viewController?.showSearchLimitAlert()
            }
        }
        else{
            
            let note = symbolData_["Note"]
            second_viewController?.userLimitReached(string_note: note as! String)
        }
        
        
        DispatchQueue.main.async {
            self.second_viewController?.processSymbolsData()
        }
    }
    
}
