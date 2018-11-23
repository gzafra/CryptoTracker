//
//  DateExtensions.swift
//  CryptoTracker
//
//  Created by Guillermo Zafra on 27/09/2018.
//  Copyright © 2018 Guillermo Zafra. All rights reserved.
//

import Foundation

class DateFormatterHelper {
    private static var dateFormatter: DateFormatter = {
        var numberFormatter = DateFormatter()
        return numberFormatter
    }()
    
    /// Formats a given date in format (yyyy-MM-dd)
    static func formattedString(from date: Date) -> String {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    /// Formats a given date in format (MM-dd)
    static func formattedShortString(from date: Date) -> String {
        dateFormatter.dateFormat = "MM-dd"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
}
