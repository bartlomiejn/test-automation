//
//  AuthenticationActions.swift
//  redux-swift
//
//  Created by Bartłomiej Nowak on 04.05.2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import Foundation

typealias AuthenticationErrorClosure = (AuthenticationError) -> Void

enum AuthenticationError {
    case recoverable
    case unrecoverable
}

protocol AuthenticationInteractorInterface {
    func signIn(
        username: String,
        password: String,
        success: () -> Void,
        failure: AuthenticationErrorClosure
    )
}

class AuthenticationInteractor: AuthenticationInteractorInterface {
    
    private let service: AuthenticationServiceInterface
    
    init(service: AuthenticationServiceInterface) {
        self.service = service
    }
    
    func signIn(
        username: String,
        password: String,
        success: () -> Void,
        failure: AuthenticationErrorClosure
    ) {
        service.signIn(username: username, password: password, successCallback: {
            
        }, failureCallback: { error in
            
        })
    }
}
