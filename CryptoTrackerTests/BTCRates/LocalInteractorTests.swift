//
//  LocalInteractorTests.swift
//  CryptoTrackerTests
//
//  Created by Guillermo Zafra on 29/09/2018.
//  Copyright © 2018 Guillermo Zafra. All rights reserved.
//

import XCTest
@testable import CryptoTracker

class LocalInteractorTests: XCTestCase {
    
    
    func testHistoricalCache() {
        let localInteractor = RatesLocalInteractor()
        let mockHistoricalData: RatesHistoricalData = MockHelper.historicalData
        localInteractor.save(historicalRates: mockHistoricalData)
        
        let cachedData = localInteractor.fetchLocalHistorical()
        XCTAssertNotNil(cachedData)
        XCTAssertEqual(cachedData!.days.count, mockHistoricalData.days.count)
    }
    
    func testRealTimeCache() {
        let localInteractor = RatesLocalInteractor()
        let mockRealTimeData: RatesRealTimeData = MockHelper.realTimeData
        localInteractor.save(realTimeRate: mockRealTimeData)
        
        let cachedData = localInteractor.fetchLocalRealTimeRate()
        XCTAssertNotNil(cachedData)
        XCTAssertEqual(cachedData!.currencies.count, mockRealTimeData.currencies.count)
    }
    
}
