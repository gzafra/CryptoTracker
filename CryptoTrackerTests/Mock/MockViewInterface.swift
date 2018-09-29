//
//  MockViewInterface.swift
//  CryptoTrackerTests
//
//  Created by Guillermo Zafra on 29/09/2018.
//  Copyright © 2018 Guillermo Zafra. All rights reserved.
//

import Foundation
@testable import CryptoTracker

class MockViewInterface: RatesViewInterface {
    var presenter: RatesPresenterProtocol?
    
    var historicalViewModel: HistoricalRatesViewModel?
    var realtimeViewModel: RateViewModel?
    
    var didShowError: Bool = false
    
    func viewShouldUpdateHistorical(with viewModel: HistoricalRatesViewModel) {
        historicalViewModel = viewModel
    }
    
    func viewShouldUpdateRealTime(with viewModel: RateViewModel) {
        realtimeViewModel = viewModel
    }
    
    func showError(message: String) {
        didShowError = true
    }
    
    
}
