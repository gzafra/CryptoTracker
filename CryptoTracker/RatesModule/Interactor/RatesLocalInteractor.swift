//
//  RatesLocalInteractor.swift
//  CryptoTracker
//
//  Created by Guillermo Zafra on 29/09/2018.
//  Copyright © 2018 Guillermo Zafra. All rights reserved.
//

import Foundation

/**
 RatesLocalInteractor
 
 - Allows for caching and fetching from cache
 
 */
final class RatesLocalInteractor: RatesLocalInteractorProtocol, Cacheable {
    var cacheName: String {
        return Constants.cacheName
    }
    
    private enum Constants {
        static let historicalCache = "Historical"
        static let realtimeCache = "RealTime"
        static let cacheName = "Rates"
    }
    
    func fetchLocalHistorical() -> RatesHistoricalData? {
        let data: RatesHistoricalData? = getCache(for: Constants.historicalCache)
        return data
    }
    
    func fetchLocalRealTimeRate() -> RatesRealTimeData? {
        let data: RatesRealTimeData? = getCache(for: Constants.realtimeCache)
        return data
    }
    
    func save(historicalRates: RatesHistoricalData) {
        try? cache(historicalRates, with: Constants.historicalCache)
    }
    
    func save(realTimeRate: RatesRealTimeData) {
        try? cache(realTimeRate, with: Constants.realtimeCache)
    }
}
