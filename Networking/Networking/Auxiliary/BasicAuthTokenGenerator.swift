//
//  BasicAuthTokenGenerator.swift
//  redux-swift
//
//  Created by Bartłomiej Nowak on 06.05.2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import Foundation

public struct BasicTokenGenerationError: Error {}

public struct BasicAuthTokenGenerator {
    
    public init() {}
    
    public func token(from username: String, password: String) throws -> String {
        if let token = "\(username):\(password)".data(using: .utf8)?.base64EncodedString() {
            return token
        } else {
            throw BasicTokenGenerationError()
        }
    }
}
