//
//  RequestManager.swift
//  CryptoTracker
//
//  Created by Guillermo Zafra on 27/09/2018.
//  Copyright © 2018 Guillermo Zafra. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get
    case head
    case post
    case put
    case patch
    case delete
}

class RequestManager: RequestManagerProtocol {
    
    private static func defaultConfiguration() -> URLSessionConfiguration {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 30
        return configuration
    }
    
    private let sessionConfiguration: URLSessionConfiguration
    
    
    // MARK: - Lifecycle
    init(sessionConfiguration: URLSessionConfiguration = RequestManager.defaultConfiguration()) {
        self.sessionConfiguration = sessionConfiguration
    }

    // MARK: - Request Methods
    func send<T: RequestProtocol>(request: T, after: TimeInterval) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + after) {
            self.send(request: request)
        }
    }
    
    func send<T: RequestProtocol>(request: T) {

        guard var url = request.url else {
            assertionFailure("Error creating URL for endpoint: \(String(describing: request))")
            return
        }
        
        if let queryDictionary = request.queryString {
            let urlParams = queryDictionary.compactMap({ (key, value) -> String in
                return "\(key)=\(value)"
            }).joined(separator: "&")
            
            let queryString = url.absoluteString + "?" + urlParams
            if let queryURL = URL(string: queryString) {
                url = queryURL
            }
        }
        
        var httpRequest = URLRequest(url: url)
        
        httpRequest.httpMethod = request.method.rawValue
        if request.method == .post || request.method == .put {
            assert(request.body != nil, "Body is nil and it shouldn't")
            httpRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            httpRequest.httpBody = request.body
        }

        let session = URLSession(configuration: sessionConfiguration)
        let task = session.dataTask(with: httpRequest) { (serverData, responseData, error) in
            DispatchQueue.main.async {
                
                if let error = error {
                   request.completion?(Result.failure(ResultError.networkError(underlaying: error)))
                    return
                }
                
                let httpCode: HTTPCode = HTTPCode(intValue: (responseData as? HTTPURLResponse)?.statusCode ?? 0)
                
                if !httpCode.isSuccess {
                    request.completion?(Result.failure(ResultError.serverError(code: httpCode)))

                    return
                }
                
                // If method is DELETE or no data, return success
                guard request.method != .delete, let data = serverData else {
                    request.completion?(Result.success(nil))
                    return
                }
                do {
                    let processedData = try request.processResponseData(data: data)
                    request.completion?(Result.success(processedData))
                    
                } catch {
                    request.completion?(Result.failure(ResultError.parsingError(message: error.localizedDescription)))
                }
            }
            
        }
        
        task.resume()
    }
}
