//
//  CurrencyFomatter.swift
//  CryptoTracker
//
//  Created by Guillermo Zafra on 27/09/2018.
//  Copyright © 2018 Guillermo Zafra. All rights reserved.
//

import Foundation

class CurrencyFormatter {
    private static var numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.roundingMode = .down
        return numberFormatter
    }()
    
    /// Formats a Double value to show as a currency value with provided symbol (suffix)
    static func format(rate: Double, currencyCode: String) -> String {
        numberFormatter.currencyCode = currencyCode
        guard let stringValue = numberFormatter.string(for: rate) else { return "#####" }
        return stringValue
    }
}
