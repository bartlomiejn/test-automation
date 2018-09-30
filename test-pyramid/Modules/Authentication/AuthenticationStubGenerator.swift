//
//  AuthenticationStubGenerator.swift
//  TestPyramid
//
//  Created by Bartłomiej Nowak on 30/09/2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import Foundation

enum AuthenticationStub: String {
    case success
}

class AuthenticationStubGenerator: StubGenerator {
    
    let stub: AuthenticationStub
    
    init?(parameter: String) {
        guard let stub = AuthenticationStub(rawValue: parameter) else {
            return nil
        }
        self.stub = stub
    }
    
    func injectStubs(into client: HTTPNetworkClient) {
        switch stub {
        case .success:
            try! client.stub(AuthenticationService.Path.user, .GET, statusCode: 200, body: nil, headers: nil)
        }
    }
}
