//
//  CoinDeskRealTimeData.swift
//  CryptoTracker
//
//  Created by Guillermo Zafra on 27/09/2018.
//  Copyright © 2018 Guillermo Zafra. All rights reserved.
//

import Foundation

struct RatesRealTimeData: Decodable {
    let chartName: String
    let currencies: [String: CoinDeskRealTimeCurrency]
    
    enum CodingKeys: String, CodingKey {
        case chartName
        case currencies = "bpi"
    }
}

struct CoinDeskRealTimeCurrency: Decodable {
    let code: String
    let symbol: String
    let rate: Double
    
    enum CodingKeys: String, CodingKey {
        case code
        case symbol
        case rate = "rate_float"
    }
}
