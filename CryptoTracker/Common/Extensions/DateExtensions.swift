//
//  DateExtensions.swift
//  CryptoTracker
//
//  Created by Guillermo Zafra on 27/09/2018.
//  Copyright © 2018 Guillermo Zafra. All rights reserved.
//

import Foundation

extension Date {
    /// Formats a given date in short format (yyyy-MM-dd)
    var formattedShortString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: self)
        return dateString
    }
}
