//
//  Endpoints.swift
//  CryptoTracker
//
//  Created by Guillermo Zafra on 27/09/2018.
//  Copyright © 2018 Guillermo Zafra. All rights reserved.
//

import Foundation

protocol EndpointProtocol: RawRepresentable where RawValue == String {
    var baseUrl: String { get }
    var url: URL? { get }
}

extension EndpointProtocol {
    
    init?(rawValue: String) {
        assertionFailure("init(rawValue:) not implemented")
        return nil
    }
    
    var url: URL? {
        let urlComponents = URLComponents(string: baseUrl + self.rawValue)
        return urlComponents?.url
    }
}
