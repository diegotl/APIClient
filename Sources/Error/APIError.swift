//
//  APIError.swift
//  APIClient
//
//  Created by Diego Trevisan Lara on 04/08/19.
//  Copyright © 2018 Diego Trevisan Lara. All rights reserved.
//

import Foundation

public enum APIError: LocalizedError {
    case underlying(Error)
    
    public var errorDescription: String? {
        switch self {
        case .underlying(let error):
            return error.localizedDescription
        }
    }
}
