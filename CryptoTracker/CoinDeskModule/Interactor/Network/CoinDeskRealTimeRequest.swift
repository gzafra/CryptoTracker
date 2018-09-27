//
//  CoinDeskRealTimeRequest.swift
//  CryptoTracker
//
//  Created by Guillermo Zafra on 27/09/2018.
//  Copyright © 2018 Guillermo Zafra. All rights reserved.
//

import Foundation

struct CoinDeskRealTimeRequest: RequestProtocol {
    typealias ResponseType = CoinDeskRealTimeData
    var method: HTTPMethod = .get
    
    var url: URL? = CoinDeskEndpoint.currentPrice.url
    
    var completion: ((Result<ResponseType?>) -> Void)?
}
