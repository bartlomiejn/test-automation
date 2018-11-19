//
//  AppStubGenerator.swift
//  App
//
//  Created by Bartłomiej Nowak on 30/09/2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import Networking
import Authentication

public class AppStubGenerator
{
    public let authStubGenerator: AuthenticationStubGenerator
    
    public init(from launchParameters: [String: String])
    {
        self.authStubGenerator = AuthenticationStubGenerator(from: launchParameters)
    }
}

extension AppStubGenerator: StubGenerator
{
    public func injectStubs(into client: HTTPNetworkClient)
    {
        authStubGenerator.injectStubs(into: client)
    }
}
