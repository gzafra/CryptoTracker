//
//  CoinDeskRealTimeRequest.swift
//  CryptoTracker
//
//  Created by Guillermo Zafra on 27/09/2018.
//  Copyright © 2018 Guillermo Zafra. All rights reserved.
//

import Foundation

struct RatesRealTimeRequest: RequestProtocol {
    
    typealias ResponseType = RatesRealTimeData
    var method: HTTPMethod = .get
    
    var url: URL? = CoinDeskEndpoint.currentPrice.url
    
    var completion: ((Result<RatesRealTimeData>) -> Void)?
}
