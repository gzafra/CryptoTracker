//
//  CoinDeskEndpoints.swift
//  CryptoTracker
//
//  Created by Guillermo Zafra on 27/09/2018.
//  Copyright © 2018 Guillermo Zafra. All rights reserved.
//

import Foundation

/**
 CoinDesk API Endpoints
 
 TODO: Should include these in the plist config as well as the Base URL
 */
enum CoinDeskEndpoint: String, EndpointProtocol {
    case currentPrice = "/currentprice.json"
    case historical = "/historical/close.json"
    
    
    var baseUrl: String {
        return "https://api.coindesk.com/v1/bpi"
    }
}
