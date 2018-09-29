//
//  CoinDeskRealTimeData.swift
//  CryptoTracker
//
//  Created by Guillermo Zafra on 27/09/2018.
//  Copyright © 2018 Guillermo Zafra. All rights reserved.
//

import Foundation

struct RatesRealTimeData: Codable {
    let chartName: String
    let currencies: [String: CoinDeskRealTimeCurrency]
    
    private enum Constants {
        static let defaultCurrencyCode = "USD"
    }
    
    var usd: CoinDeskRealTimeCurrency? {
        guard let usdCurrency = currencies[Constants.defaultCurrencyCode] else { return nil }
        return usdCurrency
    }
    
    enum CodingKeys: String, CodingKey {
        case chartName
        case currencies = "bpi"
    }
}

struct CoinDeskRealTimeCurrency: Codable {
    let code: String
    let symbol: String
    let rate: Double
    
    enum CodingKeys: String, CodingKey {
        case code
        case symbol
        case rate = "rate_float"
    }
}
