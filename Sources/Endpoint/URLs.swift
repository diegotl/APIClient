//
//  APIEndpointPath.swift
//  APIClient
//
//  Created by Diego Trevisan Lara on 19/01/18.
//  Copyright © 2018 Diego Trevisan Lara. All rights reserved.
//

import Foundation

// MARK: - Enums

struct APIEndpointUrl {
    let environment: APIEnvionment
    let path: EndpointPath
    
    init(environment: APIEnvionment = .current, path: EndpointPath) {
        self.environment = environment
        self.path = path
    }
    
    var url: String {
        return "\(environment.baseUrl)\(path.value)"
    }
}

// MARK: - Environment

@objc public enum APIEnvionment: Int {
    case production
    case sandbox
    
    var baseUrl: String {
        switch self {
        case .production:
            return "https://www.boletobancario.com/boletofacil/integration/api"
        case .sandbox:
            return "https://sandbox.boletobancario.com/boletofacil/integration/api"
        }
    }
    
    static var current: APIEnvionment = .production
}

// MARK: - Endpoint Path

protocol EndpointPath {
    var value: String { get }
}
