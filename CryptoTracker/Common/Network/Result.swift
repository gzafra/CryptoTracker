//
//  Result.swift
//  CryptoTracker
//
//  Created by Guillermo Zafra on 27/09/2018.
//  Copyright © 2018 Guillermo Zafra. All rights reserved.
//

import Foundation

enum Result<T: Decodable> {
    case success(T)
    case failure(ResultError)
}
