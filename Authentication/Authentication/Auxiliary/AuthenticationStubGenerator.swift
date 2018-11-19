//
//  AuthenticationStubGenerator.swift
//  TestAutomationExample
//
//  Created by Bartłomiej Nowak on 08/10/2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import Networking

public enum AuthenticationStub: String
{
    case ok
    case unauthorized
    case none
}

public class AuthenticationStubGenerator
{
    public enum Parameter
    {
        static let auth = "auth"
    }
    
    public let stub: AuthenticationStub
    
    public init(from launchParameters: [String: String])
    {
        if let parameter = launchParameters[Parameter.auth],
        let stub = AuthenticationStub(rawValue: parameter) {
            self.stub = stub
        } else {
            self.stub = .none
        }
    }
}

extension AuthenticationStubGenerator: StubGenerator
{
    public func injectStubs(into client: HTTPNetworkClient)
    {
        switch stub {
        case .ok:
            try! client.stub(AuthenticationService.Path.user, .GET, statusCode: 200, body: nil, headers: nil)
        case .unauthorized:
            try! client.stub(AuthenticationService.Path.user, .GET, statusCode: 401, body: nil, headers: nil)
        case .none:
            break
        }
    }
}
