//
//  CoinDeskHistoricalRequest.swift
//  CryptoTracker
//
//  Created by Guillermo Zafra on 27/09/2018.
//  Copyright © 2018 Guillermo Zafra. All rights reserved.
//

import Foundation

struct RatesHistoricalRequest: RequestProtocol {

    var completion: ((Result<RatesHistoricalData>) -> Void)?
    
    typealias ResponseType = RatesHistoricalData
    var method: HTTPMethod = .get
    
    var url: URL? = CoinDeskEndpoint.historical.url
    
    
    var queryString: [String : String]?
    
    
    private enum Keys {
        static let start = "start"
        static let end = "end"
        static let currency = "currency"
    }
    
    init(from startDate: Date, to endDate: Date? = nil, currency: String?) {
        var queryStringParams = [
            Keys.start: DateFormatterHelper.formattedString(from: startDate),
        ]
        if let endDate = endDate {
            queryStringParams[Keys.end] = DateFormatterHelper.formattedString(from: endDate)
        }
        if let currency = currency {
            queryStringParams[Keys.currency] = currency
        }
        queryString = queryStringParams
    }
}
