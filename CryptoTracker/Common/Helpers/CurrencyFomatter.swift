//
//  CurrencyFomatter.swift
//  CryptoTracker
//
//  Created by Guillermo Zafra on 27/09/2018.
//  Copyright © 2018 Guillermo Zafra. All rights reserved.
//

import Foundation

class CurrencyFormatter {
    private static var numberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.roundingMode = .down
        return numberFormatter
    }
    
    static func format(rate: Double, currencySymbol: String) -> String {
        guard let stringValue = numberFormatter.string(for: rate) else { return "#####" }
        return "\(stringValue) \(currencySymbol)"
    }
}
