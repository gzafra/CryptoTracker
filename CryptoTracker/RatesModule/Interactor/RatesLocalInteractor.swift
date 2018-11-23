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
final class RatesLocalInteractor: RatesLocalInteractorProtocol {
    let cacheManager: CacheManager
    init() {
        self.cacheManager = CacheManager(cacheName: Constants.cacheName)
    }
    
    private enum Constants {
        static let historicalCache = "Historical"
        static let realtimeCache = "RealTime"
        static let cacheName = "Rates"
    }
    
    func fetchLocalHistorical() -> RatesHistoricalData? {
        let data: RatesHistoricalData? = cacheManager.getCache(for: Constants.historicalCache)
        return data
    }
    
    func fetchLocalRealTimeRate() -> RatesRealTimeData? {
        let data: RatesRealTimeData? = cacheManager.getCache(for: Constants.realtimeCache)
        return data
    }
    
    func save(historicalRates: RatesHistoricalData) {
        try? cacheManager.cache(historicalRates, with: Constants.historicalCache)
    }
    
    func save(realTimeRate: RatesRealTimeData) {
        try? cacheManager.cache(realTimeRate, with: Constants.realtimeCache)
    }
}
