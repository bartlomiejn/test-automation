//
//  AppStubGenerator.swift
//  TestPyramid
//
//  Created by Bartłomiej Nowak on 30/09/2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import Core
import Networking
import Authentication

public class AppStubGenerator: StubGenerator {

    public let stubGenerators = [StubGenerator]()
    
    public init(from launchParameters: [String: String]) {
        self.authStubGenerator = AuthenticationStubGenerator(from: launchParameters)
    }
    
    public func injectStubs(into client: HTTPNetworkClient) {
        authStubGenerator.injectStubs(into: client)
    }
}
