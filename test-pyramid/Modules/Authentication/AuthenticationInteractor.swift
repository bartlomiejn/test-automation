//
//  AuthenticationActions.swift
//  redux-swift
//
//  Created by Bartłomiej Nowak on 04.05.2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import Foundation

struct UpdateSignInUsername: Action {
    let username: String?
}

struct UpdateSignInPassword: Action {
    let password: String?
}

struct SigningIn: Action {}

struct SignedIn: Action {}

struct FailedSigningIn: Action {}

protocol AuthenticationInteractorInterface {
    func usernameChanged(to username: String)
    func passwordChanged(to password: String)
    func signIn()
}

class AuthenticationInteractor: AuthenticationInteractorInterface {
    
    private let store: StateStoreDispatchInterface
    private let service: AuthenticationServiceInterface
    
    init(store: StateStoreDispatchInterface, service: AuthenticationServiceInterface) {
        self.store = store
        self.service = service
    }
    
    func usernameChanged(to username: String) {
        store.dispatch(UpdateSignInUsername(username: username))
    }
    
    func passwordChanged(to password: String) {
        store.dispatch(UpdateSignInPassword(password: password))
    }
    
    func signIn() {
        let state = store.state.authentication
        guard let username = state.username, let password = state.password else {
            return
        }
        store.dispatch(SigningIn())
        service.signIn(username: username, password: password, successCallback: { [weak store] in
            store?.dispatch(SignedIn())
        }, failureCallback: { [weak store] _ in
            store?.dispatch(FailedSigningIn())
        })
    }
}
