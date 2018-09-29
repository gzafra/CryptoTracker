//
//  CoinDeskProtocols.swift
//  CryptoTracker
//
//  Created by Guillermo Zafra on 27/09/2018.
//  Copyright © 2018 Guillermo Zafra. All rights reserved.
//

import Foundation

protocol RatesInteractorProtocol: class {
    func startRealTimeDataPolling()
    func fetchHistoricalData(successBlock: @escaping HistoricalDataBlock, failureBlock: @escaping ()->())
}

protocol RatesInteractorDelegate: class {
    func didUpdate(realTimeData: RatesRealTimeData)
}

protocol RatesPresenterProtocol: class {
    func viewDidLoad()
    func viewNeedsUpdatedData()
}

protocol RatesViewInterface: class {
    var presenter: RatesPresenterProtocol? { get set }
    func viewShouldUpdateHistorical(with viewModel: HistoricalRatesViewModel)
    func viewShouldUpdateRealTime(with viewModel: RateViewModel)
    func showError(message: String)
}
