//
//  CoinDeskProtocols.swift
//  CryptoTracker
//
//  Created by Guillermo Zafra on 27/09/2018.
//  Copyright © 2018 Guillermo Zafra. All rights reserved.
//

import Foundation

protocol RatesRemoteInteractorProtocol: class {
    func startRealTimeDataPolling()
    func fetchHistoricalData(successBlock: @escaping HistoricalDataBlock, failureBlock: @escaping ()->())
    func fetchRealTimeData(successBlock: @escaping RealTimeDataBlock, failureBlock: @escaping ()->()) 
}

protocol RatesLocalInteractorProtocol: class {
    func fetchLocalHistorical() -> RatesHistoricalData?
    func fetchLocalRealTimeRate() -> RatesRealTimeData?
    func save(historicalRates: RatesHistoricalData)
    func save(realTimeRate: RatesRealTimeData) 
}

protocol RatesInteractorDelegate: class {
    func didUpdate(realTimeData: RatesRealTimeData)
}

protocol RatesPresenterProtocol: class {
    var remoteInteractor: RatesRemoteInteractorProtocol? { get set }
    var localInteractor: RatesLocalInteractorProtocol? { get set }
    func viewDidLoad()
    func viewNeedsUpdatedData()
}

protocol RatesViewInterface: class {
    var presenter: RatesPresenterProtocol? { get set }
    func viewShouldUpdateHistorical(with viewModel: HistoricalRatesViewModel)
    func viewShouldUpdateRealTime(with viewModel: RateViewModel)
    func showError(message: String)
}

protocol RatesRouterProtocol: class {
    static func setupModule() -> RatesViewInterface
}
