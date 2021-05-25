//
//  FirstPresenter.swift
//  AIAInterviewProject
//
//  Created by Satya on 24/05/21.
//

import Foundation
import UIKit

class FirstPresenter: FirstPresenterProtocol {
    
    //Properties
    var first_viewController: FirstViewController? = nil
    
    var symbol_search_results: SymbolSearchResult?
    var intraData: [IntraData]?
    
    //MARK: - Initaliser Method
    required init(view: FirstViewController) {
        self.first_viewController = view
    }
    
    //MARK: - API Moethods
    func searchSymbol(string_symbol: String) {
        
        let headers = [ACCEPT : APPLICATION_JSON]
        let params_ = ["keywords":string_symbol,"apikey":AIAShare.shared.API_KEY ?? "1PHVIS1IU11QEF14"]
        
        _ = NetworkInterface.getRequest(.SYMBOL_SEARCH, headers: headers as NSDictionary, params: params_ as NSDictionary, requestCompletionHander: { (success, data, response, error, header) -> (Void)in
            
            if success{
                
                do
                {
//                    if let json_from_server = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
//
//                        print("JSON: \(json_from_server)")
//                    }
                    
                    
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
        
        let interval_time = (AIAShare.shared.INTERVAL_VALUE ?? "1") + "min"
        
        let params_ = ["symbol":string_symbol, "interval":interval_time, "apikey":AIAShare.shared.API_KEY ?? "1PHVIS1IU11QEF14"]
        
        first_viewController?.showActivityIndicator()
        
        _ = NetworkInterface.getRequest(.TIME_SERIES_INTRADAY, headers: headers as NSDictionary, params: params_ as NSDictionary, requestCompletionHander: { (success, data, response, error, header) -> (Void)in
            
            DispatchQueue.main.async {
                self.first_viewController?.stopActivityIndicator()
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
                        
                        let string_timeSeries = "Time Series " + "(" + interval_time + ")"
                        
                        if let bestMatches = json[string_timeSeries] as? NSDictionary {
                            self.processSymbolData(symbolData: bestMatches)
                        }
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
    
    //MARK: - Processing fetched data
    func processSearchDataAndPassToViews(symbol_search_data_: SymbolSearchResult){
        
        if let best_matches_ = symbol_search_data_.bestMatches{
            
            if best_matches_.count > 0{
                
                //Passing data to presenter to access in Views
                symbol_search_results = symbol_search_data_
                
                DispatchQueue.main.async {
                    self.first_viewController?.processSearchResults()
                }
            }
        }
    }
    
    func processSymbolData(symbolData: NSDictionary){
        
        intraData = [IntraData]()
        
        for key_timeSeries in symbolData.allKeys{
            
            let dictSymbol = symbolData.value(forKey: key_timeSeries as! String) as! NSDictionary
            
            var symbolInformation = SymbolInformation()
            symbolInformation.open = dictSymbol.value(forKey: "1. open") as? String
            symbolInformation.high = dictSymbol.value(forKey: "2. high") as? String
            symbolInformation.low = dictSymbol.value(forKey: "3. low") as? String

            let single_timeSeries = IntraData(timeSeriesKey: key_timeSeries as? String, timeSeriesValue: symbolInformation, name: "")
            intraData?.append(single_timeSeries)
        }
        
        DispatchQueue.main.async {
            self.first_viewController?.processSymbolIntraData()
        }
    }
    
    func handleErrorFromAPI() {
        
    }
    
    
    func restoreKeys(){
        
        let result = load(key: "API_KEY")
        if let data_result = result{
            if let string_to_data = String(data: data_result, encoding: .utf8){
                AIAShare.shared.API_KEY = string_to_data
            }
        }
        else{
            NotificationCenter.default.post(name: Notification.Name("select_third_tab"), object: nil)
        }
        
        if let string_interval = UserDefaults.standard.value(forKey: "INTERVAL_VALUE") as? String{
            AIAShare.shared.INTERVAL_VALUE = string_interval
        }
        else{
            //Interval value not configured
            NotificationCenter.default.post(name: Notification.Name("select_third_tab"), object: nil)
            
        }
        
        if let string_output = UserDefaults.standard.value(forKey: "OUTPUT_VALUE") as? String{
            AIAShare.shared.OUTPUT_VALUE = string_output
        }
        else{
            //output not configured
//            NotificationCenter.default.post(name: Notification.Name("select_third_tab"), object: nil)
        }
    }
    
    //MARK: - KeyChain Methods
    func save(key: String, data: Data) -> OSStatus {
        let query = [
            kSecClass as String       : kSecClassGenericPassword as String,
            kSecAttrAccount as String : key,
            kSecValueData as String   : data ] as [String : Any]
        
        SecItemDelete(query as CFDictionary)
        
        return SecItemAdd(query as CFDictionary, nil)
    }
    
    func load(key: String) -> Data? {
        let query = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : key,
            kSecReturnData as String  : kCFBooleanTrue!,
            kSecMatchLimit as String  : kSecMatchLimitOne ] as [String : Any]
        
        var dataTypeRef: AnyObject? = nil
        
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        if status == noErr {
            return dataTypeRef as! Data?
        } else {
            return nil
        }
    }
    
    func createUniqueID() -> String {
        let uuid: CFUUID = CFUUIDCreate(nil)
        let cfStr: CFString = CFUUIDCreateString(nil, uuid)
        
        let swiftString: String = cfStr as String
        return swiftString
    }
    
}
