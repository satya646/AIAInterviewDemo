//
//  AIAShared.swift
//  AIAInterviewProject
//
//  Created by Satya on 25/05/21.
//

import Foundation

class AIAShare {
    
    static let shared = AIAShare()
    
    //Making private will make sure only signle instance is created
    private init(){}
    
    var API_KEY: String?
    var INTERVAL_VALUE: String?
    var OUTPUT_VALUE: String?
    
}
