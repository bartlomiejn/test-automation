//
//  URL+isHTTP.swift
//  TestAutomationExample
//
//  Created by Bartomiej Nowak on 07/11/2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import Foundation

public extension URL {
    
    public var isHttp: Bool {
        if let components = URLComponents(url: self, resolvingAgainstBaseURL: false),
        components.scheme == "http" || components.scheme == "https" {
            return true
        } else {
            return false
        }
    }
}
