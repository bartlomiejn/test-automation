//
//  URLComponents+queryItemsDictionary.swift
//  TestAutomationExample
//
//  Created by Bartomiej Nowak on 07/11/2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import Foundation

extension URLComponents {
    
    var queryItemsDictionary: [String: String]? {
        var params = [String: String]()
        return queryItems?.reduce([:]) { _, item -> [String: String] in
            params[item.name] = item.value
            return params
        }
    }
}
