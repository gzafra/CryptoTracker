//
//  CoinDeskHistoricalData.swift
//  CryptoTracker
//
//  Created by Guillermo Zafra on 27/09/2018.
//  Copyright © 2018 Guillermo Zafra. All rights reserved.
//

import Foundation

struct CoinDeskHistoricalData: Decodable {
    let days: [String: Double]
    
    enum CodingKeys: String, CodingKey {
        case days = "bpi"
    }
}
