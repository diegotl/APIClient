//
//  APIDefaultStrategy.swift
//  APIClient
//
//  Created by Diego Trevisan Lara on 07/11/18.
//  Copyright © 2018 Diego Trevisan Lara. All rights reserved.
//

import Foundation

public struct APIDefaultStrategy: APIStrategy {
    
    public init() {}
    
    public func execute<T: Decodable>(data: Data?, response: URLResponse?, error: Error?, completion: @escaping (Result<T, APIError>) -> Void) {
        
        if let error = error {
            DispatchQueue.main.async { completion(.failure(.underlying(error))) }
        } else {
            
            do {
                let object = try T.decode(data: data!)
                DispatchQueue.main.async { completion(.success(object)) }
            } catch {
                let result: Result<T, APIError> = .failure(.underlying(error))
                DispatchQueue.main.async { completion(result) }
            }
            
        }
        
    }
    
}
