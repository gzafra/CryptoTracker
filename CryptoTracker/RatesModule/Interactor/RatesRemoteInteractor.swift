//
//  RatesInteractor.swift
//  CryptoTracker
//
//  Created by Guillermo Zafra on 27/09/2018.
//  Copyright © 2018 Guillermo Zafra. All rights reserved.
//

import Foundation


typealias HistoricalDataBlock = (RatesHistoricalData)->Void
typealias RealTimeDataBlock = (RatesRealTimeData)->Void

class RatesRemoteInteractor: RatesRemoteInteractorProtocol {
    private static let defaultPollingDelaySeconds: TimeInterval = 5.0
    
    // MARK: - Public properties
    weak var delegate: RatesInteractorDelegate?
    
    // MARK: - Private properties
    private let requestManager: RequestManagerProtocol
    private var timer: Timer?
    
    init(requestManager: RequestManagerProtocol = RequestManager()) {
        self.requestManager = requestManager
    }
    
    // MARK: - Polling
    func startRealTimeDataPolling() {
        pollRealTimeData()
    }
    
    private func pollRealTimeData(after: TimeInterval = 0.0) {
        timer = Timer.scheduledTimer(withTimeInterval: after, repeats: false, block: { [weak self] timer in
            self?.fetchRealTimeData(successBlock: { (data) in
                self?.delegate?.didUpdate(realTimeData: data)
            }, failureBlock: {
                // TODO: Retry instantly with increase delay time, for now just skip this one
            })
            self?.pollRealTimeData(after: RatesRemoteInteractor.defaultPollingDelaySeconds)
        })
    }
    
    // MARK: - Async fetching
    func fetchRealTimeData(successBlock: @escaping RealTimeDataBlock, failureBlock: @escaping ()->()) {
        var realTimeRequest = RatesRealTimeRequest()
        realTimeRequest.completion = { result in
            switch result {
            case .success(let data):
                guard let data = data else { return }
                successBlock(data)
            case .failure(_):
                failureBlock()
                break
            }
        }
        
        requestManager.send(request: realTimeRequest)
    }

    func fetchHistoricalData(successBlock: @escaping HistoricalDataBlock, failureBlock: @escaping ()->()) {
        guard let twoWeeksSinceNow = Calendar.current.date(byAdding: .day, value: -14, to: Date()) else { return }
        var historicalRequest = RatesHistoricalRequest(from: twoWeeksSinceNow, currency: "EUR")
        historicalRequest.completion = { result in
            switch result {
            case .success(let data):
                guard let data = data else { return }
                successBlock(data)
            case .failure(_):
                failureBlock()
                break
            }
        }
        
        requestManager.send(request: historicalRequest)
    }
    
    
}
