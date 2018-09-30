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
        static let usdCurrencyCode = "USD"
        static let eurCurrencycode = "EUR"
    }

    /// The default currency, currently EUR. TODO: Should be set in config
    var defaultCurrency: CoinDeskRealTimeCurrency? {
        guard let currency = currencies[Constants.eurCurrencycode] else { return nil }
        return currency
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
