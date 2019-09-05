//
//  APIError.swift
//  APIClient
//
//  Created by Diego Trevisan Lara on 04/08/19.
//  Copyright © 2018 Diego Trevisan Lara. All rights reserved.
//

import Foundation

enum APIError: LocalizedError {
    case underlying(Error)
}
