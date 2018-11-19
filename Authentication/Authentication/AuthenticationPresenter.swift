//
//  AuthenticationPresenter.swift
//  redux-swift
//
//  Created by Bartłomiej Nowak on 05.05.2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import Core

protocol AuthenticationPresenterInterface
{
    func usernameChanged(to username: String)
    func passwordChanged(to password: String)
    func tappedSignIn()
}

final class AuthenticationPresenter
{
    private weak var view: AuthenticationViewInterface?
    private let module: AuthenticationModuleProtocol
    private let interactor: AuthenticationInteractorInterface
    private var currentUsername: String?
    private var currentPassword: String?
    
    init(
        module: AuthenticationModuleProtocol,
        view: AuthenticationViewInterface,
        interactor: AuthenticationInteractorInterface
    ) {
        self.module = module
        self.view = view
        self.interactor = interactor
    }
}

extension AuthenticationPresenter: AuthenticationPresenterInterface
{
    func usernameChanged(to username: String)
    {
         currentUsername = username
    }
    
    func passwordChanged(to password: String)
    {
        currentPassword = password
    }
    
    func tappedSignIn()
    {
        guard let username = currentUsername, let password = currentPassword else {
            return
        }
        view?.disableSignInButton()
        view?.hideError()
        view?.showSpinner()
        interactor.signIn(username: username, password: password, success: { [weak self] in
            self?.signedIn()
        }, failure: { [weak self] error in
            self?.handle(error)
        })
    }
    
    private func signedIn()
    {
        view?.enableSignInButton()
        view?.hideSpinner()
        module.success()
    }

    private func handle(_ error: AuthenticationError)
    {
        view?.enableSignInButton()
        view?.hideSpinner()
        view?.showError(description: message(for: error))
    }
    
    private func message(for error: AuthenticationError) -> String
    {
        switch error {
        case .unrecoverable:
            return "Unrecoverable error."
        case .recoverable(let type):
            switch type {
            case .invalidCredentials:
                return "Invalid credentials."
            case .response(let message):
                return message ?? "Recoverable error without a message."
            }
        }
    }
}
