//
//  AuthenticationActions.swift
//  Authentication
//
//  Created by Bartłomiej Nowak on 04.05.2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import Foundation

typealias AuthenticationErrorClosure = (AuthenticationError) -> Void

protocol AuthenticationInteractorInterface
{
    func signIn(
        username: String,
        password: String,
        success: @escaping () -> Void,
        failure: @escaping AuthenticationErrorClosure
    )
}

class AuthenticationInteractor: AuthenticationInteractorInterface
{
    private let service: AuthenticationServiceInterface
    
    init(service: AuthenticationServiceInterface)
    {
        self.service = service
    }
    
    func signIn(
        username: String,
        password: String,
        success: @escaping () -> Void,
        failure: @escaping AuthenticationErrorClosure
    ) {
        service.signIn(username: username, password: password, success: success, failure: failure)
    }
}
