//
//  File.swift
//  
//
//  Created by Diego Trevisan Lara on 25.01.21.
//

import Foundation
import Combine

public class APIClient: APIClientProtocol {

    let adapters: [RequestAdapter]
    
    public init(adapters: [RequestAdapter] = []) {
        self.adapters = adapters
    }

    func execute<T: Decodable>(apiRequest: APIRequest) -> AnyPublisher<T, Error> {
        var request = apiRequest.build()
        adapters.forEach({ request = $0.adapt(request) })

        return session
            .dataTaskPublisher(for: request)
            .tryMap { [weak self] (data, response) in
                self?.adapters.forEach { $0.complete(request: request, response: response, data: data) }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
}
