//
//  RequestProtocol.swift
//  CryptoTracker
//
//  Created by Guillermo Zafra on 27/09/2018.
//  Copyright © 2018 Guillermo Zafra. All rights reserved.
//

import Foundation


struct EmptyBody: Decodable {}

protocol RequestProtocol {
    
    /// Associated type use to decode the response received (Must conform to Decodable)
    associatedtype ResponseType: Decodable

    /// HTTP methods used in the request (GET, POST, PUT, DELETE)
    var method: HTTPMethod { get set }
    
    /// URL used in the request
    var url: URL? { get set }
    
    /// Computed property that will encode 'encodableBody' into Data to be sent in the body of the request
    var body: Data? { get }
    
    /// Block called upon request completion. Returns a Result enum with either success or failure
    var completion: ((Result<ResponseType>)->Void)? { get set }
    
    /// Optional method to process and parse received Data from request. By default decodes Data into specified associatedtype
    func processResponseData(data: Data?) throws -> ResponseType
    
    /// Custom query string parameters for the URL
    var queryString: [String: String]? { get }
}

extension RequestProtocol {
    

    func processResponseData(data: Data?) throws -> ResponseType {
        guard let data = data else { throw ResultError.parsingError(message: "Expected data but nothing was found") }
        return try parseCodable(fromData: data)
    }

    private func parseCodable<ResponseType: Decodable>(fromData data: Data) throws -> ResponseType {
        return try JSONDecoder().decode(ResponseType.self, from: data)
    }
    
    var body: Data? {
        return nil
    }
    
    var queryString: [String: String]? {
        return nil
    }
}
