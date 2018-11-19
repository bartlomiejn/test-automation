//
//  URLGenerator.swift
//  Networking
//
//  Created by Bartłomiej Nowak on 06.05.2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import Foundation

public struct URLGenerator
{
    struct Error: Swift.Error
    {
        let `protocol`: String
        let host: String
        let path: String?
    }

    var `protocol` = "https"
    var host = "api.github.com"
    
    public init() {}
    
    public func url(path: String? = nil) throws -> URL
    {
        var components = URLComponents(string: "\(`protocol`)://\(host)")
        components?.path = path ?? ""
        if let url = components?.url {
            return url
        } else {
            throw Error(protocol: `protocol`, host: host, path: path)
        }
    }
}
