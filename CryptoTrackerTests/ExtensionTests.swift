//
//  ExtensionTests.swift
//  CryptoTrackerTests
//
//  Created by Guillermo Zafra on 29/09/2018.
//  Copyright © 2018 Guillermo Zafra. All rights reserved.
//

import XCTest
@testable import CryptoTracker

class ExtensionTests: XCTestCase {
    
    // MARK: - Date Extensions
    func testDateFormatted() {
        let now = Date()
        let formatted = DateFormatterHelper.formattedString(from: now)
        XCTAssertEqual(formatted.count, 10)
        XCTAssertEqual(formatted.split(separator: "-").count, 3)
    }
    
    func testDateFormattedShort() {
        let now = Date()
        let formatted = DateFormatterHelper.formattedShortString(from: now)
        XCTAssertEqual(formatted.count, 5)
        XCTAssertEqual(formatted.split(separator: "-").count, 2)
    }
    
    // MARK: - String Extensions
    func testHtmlDecoder() {
        let htmlString = "&#36;"
        let decodedHtml = HtmlDecoder.decode(string: htmlString)
        XCTAssertEqual(decodedHtml, "$")
    }
    
    // MARK: - Currency Formatter
    func testCurrencyFormatter() {
        let value: Double = 1234.5678
        let currency = "USD"
        let formatted = CurrencyFormatter.format(rate: value, currencyCode: currency)
        XCTAssertEqual(formatted, "$1,234.56")
    }
}
