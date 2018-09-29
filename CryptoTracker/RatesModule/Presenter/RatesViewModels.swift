//
//  RatesViewModel.swift
//  CryptoTracker
//
//  Created by Guillermo Zafra on 27/09/2018.
//  Copyright © 2018 Guillermo Zafra. All rights reserved.
//

import Foundation

struct HistoricalRatesViewModel {
    
    let numberOfSections: Int = 1
    var numberOfRows: Int {
        return historialRates.count
    }
    let historialRates: [RateViewModel]
}

struct RateViewModel {
    
    let stringTitle: String
    let stringRate: String
}
