//
//  AuthenticationPresenter.swift
//  redux-swift
//
//  Created by Bartłomiej Nowak on 05.05.2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import Foundation

protocol AuthenticationPresenterInterface {
    func usernameChanged(to username: String)
    func passwordChanged(to password: String)
    func tappedSignIn()
}

class AuthenticationPresenter: AuthenticationPresenterInterface {
    
    private let view: AuthenticationViewInterface
    private let store: StateStoreListeningInterface
    private let interactor: AuthenticationInteractorInterface
    private var lastState: AuthenticationState
    
    init(
        view: AuthenticationViewInterface,
        store: StateStoreListeningInterface,
        interactor: AuthenticationInteractorInterface
    ) {
        self.view = view
        self.store = store
        self.interactor = interactor
        lastState = store.state.authentication
        store.subscribe(self)
    }
    
    deinit {
        store.unsubscribe(self)
    }
    
    func usernameChanged(to username: String) {
        interactor.usernameChanged(to: username)
    }
    
    func passwordChanged(to password: String) {
        interactor.passwordChanged(to: password)
    }
    
    func tappedSignIn() {
        interactor.signIn()
    }
}

extension AuthenticationPresenter: StateStoreListener {
    
    func stateChanged(to state: AppState) {
        let authenticationState = state.authentication
        guard lastState != authenticationState else {
            return
        }
        lastState = authenticationState
        updateWithLastCredentialsState()
        updateWithLastSignInState()
    }
    
    private func updateWithLastCredentialsState() {
        view.show(password: lastState.password ?? "")
        view.show(username: lastState.username ?? "")
    }
    
    private func updateWithLastSignInState() {
        switch lastState.signInState {
            case .signingIn:
                view.disableSignInButton()
                view.hideError()
                view.showSpinner()
            case .failure:
                view.enableSignInButton()
                view.showError(description: "Invalid credentials.")
                view.hideSpinner()
            case .notSignedIn, .success:
                break
        }
    }
}
