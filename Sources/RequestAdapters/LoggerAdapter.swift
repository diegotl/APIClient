//
//  LoggerAdapter.swift
//  APIClient
//
//  Created by Diego Trevisan Lara on 21/06/18.
//  Copyright © 2018 Diego Trevisan Lara. All rights reserved.
//

import Foundation
import OkLog

public struct LoggerAdapter: RequestAdapter {
    
    public func adapt(_ request: URLRequest) -> URLRequest {
        OkLog.willSend(request)
        return request
    }
    
    public func complete(request: URLRequest, response: URLResponse?, data: Data?) {
        let fullUrl = OkLog.getUrl(request: request, response: response, data: data)
        print(fullUrl)
    }
    
}
