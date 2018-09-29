//
//  RatesInteractor.swift
//  CryptoTracker
//
//  Created by Guillermo Zafra on 27/09/2018.
//  Copyright © 2018 Guillermo Zafra. All rights reserved.
//

import Foundation


typealias HistoricalDataBlock = (RatesHistoricalData)->Void

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
    
    
    func startRealTimeDataPolling() {
        fetchRealTime()
    }
    
    private func fetchRealTime(after: TimeInterval = 0.0) {
        timer = Timer.scheduledTimer(withTimeInterval: after, repeats: false, block: { [weak self] timer in
            
            var realTimeRequest = RatesRealTimeRequest()
            realTimeRequest.completion = { result in
                switch result {
                case .success(let data):
                    guard let data = data else { return }
                    self?.delegate?.didUpdate(realTimeData: data)
                case .failure(_):
                    // TODO: Should maybe retry
                    break
                }
                
                self?.fetchRealTime(after: RatesRemoteInteractor.defaultPollingDelaySeconds)
            }
            
            self?.requestManager.send(request: realTimeRequest)
        })
    }
    
    func fetchHistoricalData(successBlock: @escaping HistoricalDataBlock, failureBlock: @escaping ()->()) {
        guard let twoWeeksSinceNow = Calendar.current.date(byAdding: .day, value: -14, to: Date()) else { return }
        var historicalRequest = RatesHistoricalRequest(from: twoWeeksSinceNow)
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
