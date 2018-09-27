//
//  CoinDeskEndpoints.swift
//  CryptoTracker
//
//  Created by Guillermo Zafra on 27/09/2018.
//  Copyright © 2018 Guillermo Zafra. All rights reserved.
//

import Foundation

enum CoinDeskEndpoint: String, EndpointProtocol {
    case currentPrice = "/currentprice.json"
    case historical = "/historical/close.json"
    
    
    var baseUrl: String {
        return "https://api.coindesk.com/v1/bpi"
    }
}
