//
//  APIClient.swift
//  APIClient
//
//  Created by Diego Trevisan Lara on 07/11/18.
//  Copyright © 2018 Diego Trevisan Lara. All rights reserved.
//

import Foundation

struct APIClient: IAPIClient {
    
    let strategy: APIStrategy
    let adapters: [RequestAdapter]
    
    public init(strategy: APIStrategy, adapters: [RequestAdapter]) {
        self.strategy = strategy
        self.adapters = adapters
    }
    
    func execute<T: Decodable>(endpoint: APIEndpoint, completion: @escaping (Result<T, APIError>) -> Void) {
        
        var request = endpoint.build()
        adapters.forEach({ request = $0.adapt(request) })
        
        session.dataTask(with: request) { data, response, error in
            self.adapters.forEach({ $0.complete(request: request, response: response, data: data) })
            self.strategy.execute(data: data, response: response, error: error, completion: completion)
        }.resume()
        
    }
}
