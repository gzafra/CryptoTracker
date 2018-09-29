//
//  RequestManagerProtocol.swift
//  CryptoTracker
//
//  Created by Guillermo Zafra on 29/09/2018.
//  Copyright © 2018 Guillermo Zafra. All rights reserved.
//

import Foundation

protocol RequestManagerProtocol {
    func send<T: RequestProtocol>(request: T, after: TimeInterval)
    func send<T: RequestProtocol>(request: T)
}
