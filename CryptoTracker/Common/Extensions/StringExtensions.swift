//
//  StringExtensions.swift
//  CryptoTracker
//
//  Created by Guillermo Zafra on 27/09/2018.
//  Copyright © 2018 Guillermo Zafra. All rights reserved.
//

import Foundation

extension String {
//    
//    init(htmlEncodedString: String) {
//        self.init()
//        guard let encodedData = htmlEncodedString.data(using: .utf8) else {
//            self = htmlEncodedString
//            return
//        }
//        
//        let attributedOptions: [NSAttributedString.DocumentReadingOptionKey : Any] = [
//            .documentType: NSAttributedString.DocumentType.html,
//            .characterEncoding: String.Encoding.utf8.rawValue
//        ]
//        
//        do {
//            let attributedString = try NSAttributedString(data: encodedData, options: attributedOptions, documentAttributes: nil)
//            self = attributedString.string
//        } catch {
//            self = htmlEncodedString
//        }
//    }
//    
    var htmlDecoded: String {
        let decoded = try? NSAttributedString(data: Data(utf8), options: [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
            ], documentAttributes: nil).string
        
        return decoded ?? self
    }
}
