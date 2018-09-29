//
//  MockObjects.swift
//  CryptoTrackerTests
//
//  Created by Guillermo Zafra on 29/09/2018.
//  Copyright © 2018 Guillermo Zafra. All rights reserved.
//

import Foundation
@testable import CryptoTracker

class MockObjects {
    static var mockHistoricalData: RatesHistoricalData {
        let data = RatesHistoricalData(days: [
            "2013-09-01": 128.2597,
            "2013-09-02":127.3648,
            "2013-09-03":127.5915
            ])
        return data
    }
    
    static var mockRealTimeData: RatesRealTimeData {
        let data = RatesRealTimeData(chartName: "BTC",
                                     currencies: ["USD" : CoinDeskRealTimeCurrency(code: "USD", symbol: "$", rate: 130.33) ])
        return data
    }
}
