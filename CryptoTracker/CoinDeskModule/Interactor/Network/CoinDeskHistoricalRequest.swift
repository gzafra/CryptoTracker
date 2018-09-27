//
//  CoinDeskHistoricalRequest.swift
//  CryptoTracker
//
//  Created by Guillermo Zafra on 27/09/2018.
//  Copyright © 2018 Guillermo Zafra. All rights reserved.
//

import Foundation

struct CoinDeskHistoricalRequest: RequestProtocol {
    typealias ResponseType = CoinDeskHistoricalData
    var method: HTTPMethod = .get
    
    var url: URL? = CoinDeskEndpoint.historical.url
    
    var completion: ((Result<ResponseType?>) -> Void)?
    
    var queryString: [String : String]?
    
    init(from: Date, to: Date? = nil) {
        var queryStringParams = [
            "start": from.formattedShortString,
        ]
        if let to = to {
            queryStringParams["end"] = to.formattedShortString
        }
        queryString = queryStringParams
    }
}
