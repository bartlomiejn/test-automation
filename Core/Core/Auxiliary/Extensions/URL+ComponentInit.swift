//
//  URL+ComponentInit.swift
//  TestAutomationExample
//
//  Created by Bartomiej Nowak on 07/11/2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import Foundation

public extension URL {
    
    public init?(
        schema: String,
        host: String,
        path: String? = nil,
        parameters: [String: String]? = nil
    ) {
        var components = URLComponents()
        components.scheme = schema
        components.host = host
        components.path = path ?? ""
        let queryItems = parameters?.map { key, value -> URLQueryItem in
            return URLQueryItem.init(name: key, value: value)
        }
        components.queryItems = queryItems
        if let url = components.url {
            self = url
        } else {
            return nil
        }
    }
}
