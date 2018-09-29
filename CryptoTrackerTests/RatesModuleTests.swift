//
//  RatesModuleTests.swift
//  CryptoTrackerTests
//
//  Created by Guillermo Zafra on 29/09/2018.
//  Copyright © 2018 Guillermo Zafra. All rights reserved.
//

import XCTest
@testable import CryptoTracker

class RatesModuleTests: XCTestCase {

    func testRatesPresenterHistorical() {
        let presenter = RatesPresenter()
        
        let interactor = RatesRemoteInteractor(requestManager: MockRequestManager(promiseJson: MockRequestManagerPromises.historicalJson))
        presenter.remoteInteractor = interactor
        let mockViewInterface = MockViewInterface()
        presenter.viewInterface = mockViewInterface
        
        presenter.viewDidLoad()
        
        testExpectation(description: "Presenter did load", actionBlock: { (expectation) in
            XCTAssertNil(mockViewInterface.realtimeViewModel)
            XCTAssertNotNil(mockViewInterface.historicalViewModel)
            expectation.fulfill()
        }, waitFor: 2.0)
    }
    
    func testRatesPresenterRealtime() {
        let presenter = RatesPresenter()
        
        let interactor = RatesRemoteInteractor(requestManager: MockRequestManager(promiseJson: MockRequestManagerPromises.realTimeJson))
        presenter.remoteInteractor = interactor
        interactor.delegate = presenter
        let mockViewInterface = MockViewInterface()
        presenter.viewInterface = mockViewInterface
        
        presenter.viewDidLoad()
        
        testExpectation(description: "Real time update received on presenter", actionBlock: { (expectation) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
                XCTAssertNotNil(mockViewInterface.realtimeViewModel)
                XCTAssertNil(mockViewInterface.historicalViewModel)
                expectation.fulfill()
            })
        }, waitFor: 10.0)
    }
    
    func testRatesPresenterViewManualUpdate() {
        let presenter = RatesPresenter()
        
        let interactor = RatesRemoteInteractor(requestManager: MockRequestManager(promiseJson: MockRequestManagerPromises.historicalJson))
        presenter.remoteInteractor = interactor
        let mockViewInterface = MockViewInterface()
        presenter.viewInterface = mockViewInterface
        
        presenter.viewNeedsUpdatedData()
        
        testExpectation(description: "Presenter forced manual update", actionBlock: { (expectation) in
            XCTAssertNil(mockViewInterface.realtimeViewModel)
            XCTAssertNotNil(mockViewInterface.historicalViewModel)
            expectation.fulfill()
        }, waitFor: 2.0)
    }
    
    func testRatesPresenterError() {
        let presenter = RatesPresenter()
        let requestManager = MockRequestManager(promiseJson: MockRequestManagerPromises.historicalJson)
        requestManager.shouldSucceed = false
        let interactor = RatesRemoteInteractor(requestManager: requestManager)
        presenter.remoteInteractor = interactor
        let mockViewInterface = MockViewInterface()
        presenter.viewInterface = mockViewInterface
        
        presenter.viewDidLoad()
        
        testExpectation(description: "Presenter did load", actionBlock: { (expectation) in
            XCTAssertNil(mockViewInterface.realtimeViewModel)
            XCTAssertNil(mockViewInterface.historicalViewModel)
            XCTAssertTrue(mockViewInterface.didShowError)
            expectation.fulfill()
        }, waitFor: 2.0)
    }
    
    
}
