//
//  IntraData.swift
//  AIAInterviewProject
//
//  Created by Satya on 24/05/21.
//

import Foundation

//struct IntraData: Codable {
//
////    let metaData : MetaData?
////    let timeSeries : [String: [SymbolInformation]]?
//    let timeSeries: TimeSeriesDataKey?
//
//    private enum CodingKeys: String, CodingKey {
////        case metaData = "Meta Data"
//        case timeSeries = "Time Series (1min)"
//    }
//
//    struct MetaData: Codable{
//
//        let information : String?
//        let symbol : String?
//        let lastRefreshed : String?
//        let interval : String?
//        let outputSize : String?
//        let timeZone : String?
//
//        private enum CodingKeys: String, CodingKey {
//            case information = "1. Information"
//            case symbol = "2. Symbol"
//            case lastRefreshed = "3. Last Refreshed"
//            case interval = "4. Interval"
//            case outputSize = "5. Output Size"
//            case timeZone = "6. Time Zone"
//        }
//    }
//
//    struct TimeSeriesDataKey: Codable{
//
//        let date_time: TimeSeriesData?
//    }
//
//    struct TimeSeriesData: Codable{
//
//        let open: String?
//        let high: String?
//        let low: String?
//
//        private enum CodingKeys: String, CodingKey {
//            case open = "1. open"
//            case high = "2. high"
//            case low = "3. low"
//        }
//    }
//
//    struct SymbolInformation: Codable {
//
//        let open: String?
//        let high: String?
//        let low: String?
//        let close: String?
//        let volume: String?
//
//        private enum CodingKeys: String, CodingKey {
//            case open = "1. open"
//            case high = "2. high"
//            case low = "3. low"
//            case close = "4. close"
//            case volume = "5. volume"
//        }
//    }
//}

//struct IntraData: Decodable {
//
//    var timeSeries: DecodedArray?
//
//    private enum CodingKeys: String, CodingKey {
//        case timeSeries = "Time Series (1min)"
//    }
//}
//
//struct SymbolInformation: Decodable {
//
//    var open: String?
//    var high: String?
//    var low: String?
//    var close: String?
//    var volume: String?
//
//    private enum CodingKeys: String, CodingKey {
//        case open = "1. open"
//        case high = "2. high"
//        case low = "3. low"
//        case close = "4. close"
//        case volume = "5. volume"
//    }
//}
//
//struct DecodedArray: Decodable {
//
//    var array_symbol_information: [SymbolInformation]
//
//    // Define DynamicCodingKeys type needed for creating
//    // decoding container from JSONDecoder
//    private struct DynamicCodingKeys: CodingKey {
//
//        // Use for string-keyed dictionary
//        var stringValue: String
//        init?(stringValue: String) {
//            self.stringValue = stringValue
//        }
//
//        // Use for integer-keyed dictionary
//        var intValue: Int?
//        init?(intValue: Int) {
//            // We are not using this, thus just return nil
//            return nil
//        }
//    }
//
//    init(from decoder: Decoder) throws {
//
//        // 1
//        // Create a decoding container using DynamicCodingKeys
//        // The container will contain all the JSON first level key
//        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
//
//        var tempArray = [SymbolInformation]()
//
//        // 2
//        // Loop through each key (student ID) in container
//        for key in container.allKeys {
//
//            // Decode Student using key & keep decoded Student object in tempArray
//            let decodedObject = try container.decode(SymbolInformation.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
//            tempArray.append(decodedObject)
//        }
//
//        // 3
//        // Finish decoding all Student objects. Thus assign tempArray to array.
//        array_symbol_information = tempArray
//    }
//
//}

struct IntraData: Decodable {
    
//    let timeSeries : [String: SymbolInformation]?
    
    let timeSeriesKey: String?
    let timeSeriesValue: SymbolInformation?
    let name: String?
}

struct SymbolInformation: Decodable {

    var open: String?
    var high: String?
    var low: String?

    private enum CodingKeys: String, CodingKey {
        case open = "1. open"
        case high = "2. high"
        case low = "3. low"
    }
}








