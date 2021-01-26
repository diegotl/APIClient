//
//  File.swift
//  
//
//  Created by Diego Trevisan Lara on 25.01.21.
//

import Foundation
import Combine

protocol APIClientProtocol {
    func execute<T: Decodable>(apiRequest: APIRequest) -> AnyPublisher<T, Error>
}

extension APIClientProtocol {

    var session: URLSession {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 15.0
        return URLSession(configuration: sessionConfig)
    }

}
