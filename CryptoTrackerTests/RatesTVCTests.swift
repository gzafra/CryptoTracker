//
//  RatesTVCTests.swift
//  CryptoTrackerTests
//
//  Created by Guillermo Zafra on 29/09/2018.
//  Copyright © 2018 Guillermo Zafra. All rights reserved.
//

import XCTest
@testable import CryptoTracker

class RatesTVCTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testRouter() {
        let vc = RatesRouter.setupModule()
        guard let ratesTvc = vc as? RatesTVC else {
            XCTFail()
            return
        }
        XCTAssertNotNil(ratesTvc.presenter)
        XCTAssertNotNil(ratesTvc.presenter?.localInteractor)
        XCTAssertNotNil(ratesTvc.presenter?.remoteInteractor)
        
    }
    
    func testRatesTVC() {
        let vc = RatesRouter.setupModule()
        guard let ratesTvc = vc as? RatesTVC else {
            XCTFail()
            return
        }
        
        let mockInteractor = RatesRemoteInteractor(requestManager: MockRequestManager(promiseJson: MockRequestManagerPromises.historicalJson))
        ratesTvc.presenter?.remoteInteractor = mockInteractor
 
        ratesTvc.viewDidLoad()
        
        testExpectation(description: "RatesTVC didLoad", actionBlock: { (expectation) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
                XCTAssertNotNil(ratesTvc.tableView)
                XCTAssertGreaterThan(ratesTvc.tableView.numberOfRows(inSection: 0), 0)
                expectation.fulfill()
            })
        }, waitFor: 10.0)
    }
    
}
