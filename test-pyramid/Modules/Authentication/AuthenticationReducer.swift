//
//  AuthenticationReducer.swift
//  redux-swift
//
//  Created by Bartłomiej Nowak on 04.05.2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import Foundation

struct AuthenticationState: State, Equatable {
    enum SignInState {
        case notSignedIn
        case signingIn
        case success
        case failure
    }
    
    var signInState: SignInState
    var username: String?
    var password: String?
}

struct AuthenticationReducer {
    func reduce(action: Action, state: AuthenticationState) -> AuthenticationState {
        var mutableState = state
        switch action {
            case let action as UpdateSignInUsername:
                mutableState.username = action.username
            case let action as UpdateSignInPassword:
                mutableState.password = action.password
            case is SigningIn:
                mutableState.signInState = .signingIn
            case is SignedIn:
                mutableState.username = nil
                mutableState.password = nil
                mutableState.signInState = .success
            case is FailedSigningIn:
                mutableState.signInState = .failure
            default:
                break
        }
        return mutableState
    }
}
