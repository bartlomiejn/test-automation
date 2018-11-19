//
//  AuthenticationService.swift
//  redux-swift
//
//  Created by Bartłomiej Nowak on 06.05.2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import Networking

typealias SignInErrorClosure = (AuthenticationError) -> Void

protocol AuthenticationServiceInterface
{
    func signIn(
        username: String,
        password: String,
        success: @escaping () -> Void,
        failure: @escaping SignInErrorClosure
    )
}

final class AuthenticationService
{
    enum Path
    {
        static let user = "/user"
    }
    
    private let client: GitHubNetworkClient
    
    init(client: GitHubNetworkClient)
    {
        self.client = client
    }
}

extension AuthenticationService: AuthenticationServiceInterface
{
    func signIn(
        username: String,
        password: String,
        success: @escaping () -> Void,
        failure: @escaping SignInErrorClosure
    ) {
        do
        {
            try client.setBasicAuthToken(username: username, password: password)
            client.request(.GET, path: Path.user, success: { _ in
                success()
            }, failure: { [weak self] error in
                self?.handle(error, with: failure)
            })
        }
        catch
        {
            failure(.unrecoverable)
        }
    }
    
    private func handle(_ error: GitHubNetworkClient.Error, with callback: SignInErrorClosure)
    {
        switch error
        {
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
