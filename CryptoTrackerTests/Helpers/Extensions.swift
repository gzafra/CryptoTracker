//
//  Extensions.swift
//  CryptoTrackerTests
//
//  Created by Guillermo Zafra on 29/09/2018.
//  Copyright © 2018 Guillermo Zafra. All rights reserved.
//

import XCTest

extension XCTestCase {
    func testExpectation(description: String, actionBlock:(XCTestExpectation)->(), waitFor timeout: TimeInterval) {
        let expectation = self.expectation(description: description)
        actionBlock(expectation)
        waitForExpectations(timeout: timeout) { (error) in
            XCTAssertNil(error)
        }
    }
}


