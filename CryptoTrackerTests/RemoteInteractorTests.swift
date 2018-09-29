//
//  CryptoTrackerTests.swift
//  CryptoTrackerTests
//
//  Created by Guillermo Zafra on 27/09/2018.
//  Copyright © 2018 Guillermo Zafra. All rights reserved.
//

import XCTest
@testable import CryptoTracker

class RemoteInteractorTests: XCTestCase {
    
    func testFetchHistoricalSuccess() {
        let mockRequestManager = MockRequestManager(promiseJson: Constants.historicalJson)
        
        let remoteInteractor = RatesRemoteInteractor(requestManager: mockRequestManager)
        testExpectation(description: "Fetch Historical Data", actionBlock: { (expectation) in
            remoteInteractor.fetchHistoricalData(successBlock: { (data) in
                expectation.fulfill()
            }) {
                XCTFail()
            }
        }, waitFor: 2.0)
 
    }
    
    func testFetchHistoricalFailure() {
        let mockRequestManager = MockRequestManager(promiseJson: Constants.historicalJson)
        mockRequestManager.shouldSucceed = false
        let remoteInteractor = RatesRemoteInteractor(requestManager: mockRequestManager)
        
        remoteInteractor.fetchHistoricalData(successBlock: { (data) in
            XCTFail()
        }) {
            XCTAssert(true)
        }
    }
    
    func testFetchRealTimeRateSuccess() {
        let mockRequestManager = MockRequestManager(promiseJson: Constants.realTimeJson)
        let remoteInteractor = RatesRemoteInteractor(requestManager: mockRequestManager)
        let delegate = MockRatesInteractorDelegate()
        remoteInteractor.delegate = delegate
        remoteInteractor.startRealTimeDataPolling()
        
        testExpectation(description: "Real time data updated", actionBlock: { (expectation) in
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) {
                XCTAssertTrue(delegate.updated)
                expectation.fulfill()
            }
        }, waitFor: 10.0)
    }
    
    func testFetchRealTimeRateFailure() {
        let mockRequestManager = MockRequestManager(promiseJson: Constants.realTimeJson)
        mockRequestManager.shouldSucceed = false
        let remoteInteractor = RatesRemoteInteractor(requestManager: mockRequestManager)
        let delegate = MockRatesInteractorDelegate()
        remoteInteractor.delegate = delegate
        remoteInteractor.startRealTimeDataPolling()
        
        testExpectation(description: "Real time data not updated", actionBlock: { (expectation) in
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) {
                XCTAssertFalse(delegate.updated)
                expectation.fulfill()
            }
        }, waitFor: 10.0)
    }
    
}

// MARK: - Mock classes
final class MockRatesInteractorDelegate: RatesInteractorDelegate {
    func didUpdate(realTimeData: RatesRealTimeData) {
        updated = true
    }
    
    var updated = false


}

fileprivate enum Constants {
    static let historicalJson = "HistoricalData"
    static let realTimeJson = "RealTimeData"
}

class MockRequestManager: RequestManagerProtocol {
    var shouldSucceed: Bool = true
    
    var promiseJson: String
    
    init(promiseJson: String) {
        self.promiseJson = promiseJson
    }
    
    func send<T>(request: T, after: TimeInterval) where T : RequestProtocol {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + after) {
            self.send(request: request)
        }
    }
    func send<T: RequestProtocol>(request: T) {
        if shouldSucceed {
            guard let jsonData = loadJson(withName: promiseJson),
            let decodedData = try? request.processResponseData(data: jsonData) else { return }
            request.completion?(.success(decodedData))
        }else{
            let error = ResultError.unknownError
            request.completion?(.failure(error))
        }
    }
    
    func loadJson(withName name: String) -> Data? {
        guard let path = Bundle(for: type(of: self)).path(forResource: name, ofType: "json") else { return nil }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            return data
        } catch {
            return nil
        }
    }
}
