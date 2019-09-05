//
//  APIEndpoint.swift
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

class APIEndpoint {
    
    let url: APIEndpointUrl
    let method: HTTPMethod
    let encoding: ParameterEncoding
    
    init(url: APIEndpointUrl, method: HTTPMethod = .get, encoding: ParameterEncoding = .formUrlEncoded(nil)) {
        self.url = url
        self.method = method
        self.encoding = encoding
    }
    
    func build() -> URLRequest {
        let url = URL(string: self.url.url)!
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
            if let queryString = try? parameter?.json().queryString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
                request.url = URL(string: "\(self.url.url)?\(queryString)")!
            }
        }
        
        return request
    }
    
}
