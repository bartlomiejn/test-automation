//
//  AuthenticationService.swift
//  redux-swift
//
//  Created by Bartłomiej Nowak on 06.05.2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import Foundation

typealias SignInErrorClosure = (AuthenticationError) -> Void

protocol AuthenticationServiceInterface {
    func signIn(
        username: String,
        password: String,
        success: @escaping () -> Void,
        failure: @escaping SignInErrorClosure
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
        success: @escaping () -> Void,
        failure: @escaping SignInErrorClosure
    ) {
        do {
            try client.setBasicAuthToken(username: username, password: password)
            client.request(.GET, path: Path.user, success: { _ in
                success()
            }, failure: { [weak self] error in
                self?.handle(error, with: failure)
            })
        } catch {
            // Can fail only on setBasicAuthToken, which if fails we can't really do anything.
            failure(.unrecoverable)
        }
    }
    
    private func handle(_ error: GitHubNetworkClientError, with callback: SignInErrorClosure) {
        switch error {
        case .unauthorized:
            callback(.recoverable(.invalidCredentials))
        case .apiError(let model):
            callback(.recoverable(.response(message: model?.response?.message)))
        case .invalidResponse:
            callback(.unrecoverable)
        case .other:
            callback(.unrecoverable)
        }
    }
}
