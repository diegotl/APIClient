//
//  APIRequest.swift
//  APIClient
//
//  Created by Diego Trevisan Lara on 12/01/18.
//  Copyright © 2018 Diego Trevisan Lara. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

enum ParameterEncoding {
    case formUrlEncoded(Codable?)
    case queryString(Codable?)
    case json(Codable?)
}

public class APIRequest {
    let endpoint: APIEndpoint
    let method: HTTPMethod
    let encoding: ParameterEncoding
    
    init(endpoint: APIEndpoint, method: HTTPMethod = .get, encoding: ParameterEncoding = .formUrlEncoded(nil)) {
        self.endpoint = endpoint
        self.method = method
        self.encoding = encoding
    }
    
    func build() -> URLRequest {
        let url = URL(string: endpoint.url)!
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 15)
        request.httpMethod = method.rawValue
        
        switch encoding {
            
        case .formUrlEncoded(let parameter):
            request.allHTTPHeaderFields = ["Content-Type": "application/x-www-form-urlencoded"]
            request.httpBody = try? parameter?.json().queryString.data(using: .utf8)
            
        case .json(let parameter):
            request.allHTTPHeaderFields = ["Content-Type": "application/json"]
            request.httpBody = try? parameter?.data()
            
        case .queryString(let parameter):
            request.allHTTPHeaderFields = ["Content-Type": "application/x-www-form-urlencoded"]
            if let queryString = try? parameter?.json().queryString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
                request.url = URL(string: "\(endpoint.url)?\(queryString)")!
            }
        }
        
        return request
    }
}
