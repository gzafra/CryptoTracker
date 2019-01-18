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
    
    private func setupEnvironment(with promise: String, shouldSucceed: Bool = true) -> (presenter: RatesPresenter, mockVC: MockViewInterface) {
        let mockRequestManager = MockRequestManager(promiseJson: promise)
        mockRequestManager.shouldSucceed = shouldSucceed
        let interactor = RatesRemoteInteractor(requestManager: mockRequestManager)
        
        let presenter = RatesPresenter(remoteInteractor: interactor)
        
        interactor.delegate = presenter
        let mockVC = MockViewInterface(presenter: presenter)
        presenter.viewInterface = mockVC
        
        return (presenter: presenter, mockVC: mockVC)
    }
    func testRatesPresenterHistorical() {
        let environment = setupEnvironment(with: MockRequestManagerPromises.historicalJson)
        
        environment.presenter.viewDidLoad()
        
        testExpectation(description: "Presenter did load", actionBlock: { (expectation) in
            XCTAssertNil(environment.mockVC.realtimeViewModel)
            XCTAssertNotNil(environment.mockVC.historicalViewModel)
            expectation.fulfill()
        }, waitFor: 2.0)
    }
    
    func testRatesPresenterRealtime() {
        let environment = setupEnvironment(with: MockRequestManagerPromises.realTimeJson)
        
        environment.presenter.viewDidLoad()
        
        testExpectation(description: "Real time update received on presenter", actionBlock: { (expectation) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
                XCTAssertNotNil(environment.mockVC.realtimeViewModel)
                XCTAssertNil(environment.mockVC.historicalViewModel)
                expectation.fulfill()
            })
        }, waitFor: 10.0)
    }
    
    func testRatesPresenterViewManualUpdate() {
        let environment = setupEnvironment(with: MockRequestManagerPromises.historicalJson)
        
        environment.presenter.viewNeedsUpdatedData()
        
        testExpectation(description: "Presenter forced manual update", actionBlock: { (expectation) in
            XCTAssertNil(environment.mockVC.realtimeViewModel)
            XCTAssertNotNil(environment.mockVC.historicalViewModel)
            expectation.fulfill()
        }, waitFor: 2.0)
    }
    
    func testRatesPresenterError() {
        let environment = setupEnvironment(with: MockRequestManagerPromises.historicalJson, shouldSucceed: false)
        
        environment.presenter.viewDidLoad()
        
        testExpectation(description: "Presenter did load", actionBlock: { (expectation) in
            XCTAssertNil(environment.mockVC.realtimeViewModel)
            XCTAssertNil(environment.mockVC.historicalViewModel)
            XCTAssertTrue(environment.mockVC.didShowError)
            expectation.fulfill()
        }, waitFor: 2.0)
    }
    
    
}
