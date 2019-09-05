//
//  APIStrategy.swift
//  APIClient
//
//  Created by Diego Trevisan Lara on 07/11/18.
//  Copyright © 2018 Diego Trevisan Lara. All rights reserved.
//

import Foundation

protocol APIStrategy {
    func execute<T: Decodable>(data: Data?, response: URLResponse?, error: Error?, completion: @escaping (Result<T, APIError>) -> Void)
}
