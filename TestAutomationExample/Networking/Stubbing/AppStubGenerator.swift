//
//  AppStubGenerator.swift
//  TestPyramid
//
//  Created by Bartłomiej Nowak on 30/09/2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import Foundation

class AppStubGenerator: StubGenerator {

    let authStubGenerator: AuthenticationStubGenerator
    
    init(from launchParameters: [String: String]) {
        self.authStubGenerator = AuthenticationStubGenerator(from: launchParameters)
    }
    
    func injectStubs(into client: HTTPNetworkClient) {
        authStubGenerator.injectStubs(into: client)
    }
}
