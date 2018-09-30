//
//  AuthenticationService.swift
//  redux-swift
//
//  Created by Bartłomiej Nowak on 06.05.2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import Foundation

typealias SignInErrorCallback = (AuthenticationError) -> Void

protocol AuthenticationServiceInterface {
    func signIn(
        username: String,
        password: String,
        successCallback: @escaping () -> Void,
        failureCallback: @escaping SignInErrorCallback
    )
}

class AuthenticationService: AuthenticationServiceInterface {
    
    enum Path {
        static let user = "/user"
    }
    
    private let client: GitHubNetworkClient
    
    init(client: GitHubNetworkClient) {
        self.client = client
    }
    
    func signIn(
        username: String,
        password: String,
        successCallback: @escaping () -> Void,
        failureCallback: @escaping SignInErrorCallback
    ) {
        do {
            try client.setBasicAuthToken(username: username, password: password)
            client.request(.GET, path: Path.user, successCallback: { _ in
                successCallback()
            }, failureCallback: { [weak self] error in
                self?.handle(error, with: failureCallback)
            })
        } catch is BasicTokenGenerationError {
            failureCallback(.unrecoverable)
        } catch {
            failureCallback(.recoverable)
        }
    }
    
    private func handle(_ error: GitHubNetworkClientError, with callback: SignInErrorCallback) {
        switch error {
        case .unauthorized:
            break
        case .invalidResponse:
            break
        case .apiError(let response):
            break
        case .other:
            break
        }
    }
}
