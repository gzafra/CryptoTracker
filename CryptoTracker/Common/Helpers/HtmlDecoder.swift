//
//  HtmlDecoder.swift
//  CryptoTracker
//
//  Created by Guillermo Zafra on 15/01/2019.
//  Copyright © 2019 Guillermo Zafra. All rights reserved.
//

import Foundation

class HtmlDecoder {
    
    /// Decodes the string containing html symbols and entities
    static func decode(string: String) -> String {
        let decoded = try? NSAttributedString(data: Data(string.utf8), options: [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
            ], documentAttributes: nil).string
        
        return decoded ?? string
    }
}
