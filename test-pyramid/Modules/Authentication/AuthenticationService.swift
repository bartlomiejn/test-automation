//
//  AuthenticationService.swift
//  redux-swift
//
//  Created by Bartłomiej Nowak on 06.05.2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import Foundation

protocol AuthenticationServiceInterface {
    func signIn(
        username: String, password: String, successCallback: @escaping () -> Void, failureCallback: ((Error?) -> Void)?
    )
}

class AuthenticationService: AuthenticationServiceInterface {
    
    private let client: GitHubNetworkClient
    
    init(client: GitHubNetworkClient) {
        self.client = client
    }
    
    func signIn(
        username: String, password: String, successCallback: @escaping () -> Void, failureCallback: ((Error?) -> Void)?
    ) {
        do {
            try client.setBasicAuthToken(username: username, password: password)
            client.request(.GET, path: "/user", successCallback: { _ in
                successCallback()
            }, failureCallback: failureCallback)
        } catch {
            failureCallback?(error)
        }
    }
}
