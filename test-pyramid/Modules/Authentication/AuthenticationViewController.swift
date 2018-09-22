//
//  AuthenticationViewController.swift
//  redux-swift
//
//  Created by Bartłomiej Nowak on 29.04.2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import UIKit

protocol AuthenticationViewInterface {
    func enableSignInButton()
    func disableSignInButton()
    func show(username: String)
    func show(password: String)
    func showSpinner()
    func hideSpinner()
    func showError(description: String)
    func hideError()
}

class AuthenticationViewController: UIViewController {

    private struct Constant {
        static let expansionDuration: TimeInterval = 0.25
    }
    
    var presenter: AuthenticationPresenter!
    @IBOutlet private (set) weak var usernameField: UITextField!
    @IBOutlet private (set) weak var passwordField: UITextField!
    @IBOutlet private (set) weak var errorLabelContainer: UIView!
    @IBOutlet private (set) weak var errorLabel: UILabel!
    @IBOutlet private (set) weak var signInButton: UIButton!
    @IBOutlet private (set) weak var spinner: UIActivityIndicatorView!
    private var isSignInButtonActionEnabled = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabelContainer.isHidden = true
        spinner.stopAnimating()
    }
    
    @IBAction private func textChanged(_ sender: UITextField) {
        if sender == usernameField, let text = sender.text {
            presenter.usernameChanged(to: text)
        } else if sender == passwordField, let text = sender.text {
            presenter.passwordChanged(to: text)
        }
    }
    
    @IBAction private func signIn() {
        if isSignInButtonActionEnabled {
            presenter.tappedSignIn()
        }
    }
}

extension AuthenticationViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            passwordField.resignFirstResponder()
        }
        return true
    }
}

extension AuthenticationViewController: AuthenticationViewInterface {
    
    func enableSignInButton() {
        isSignInButtonActionEnabled = true
    }
    
    func disableSignInButton() {
        isSignInButtonActionEnabled = false
    }
    
    func show(username: String) {
        usernameField.text = username
    }
    
    func show(password: String) {
        passwordField.text = password
    }
    
    func showSpinner() {
        spinner.startAnimating()
    }
    
    func hideSpinner() {
        spinner.stopAnimating()
    }
    
    func showError(description: String) {
        errorLabel.text = description
        UIView.animate(withDuration: Constant.expansionDuration) { [weak errorLabelContainer] in
            errorLabelContainer?.isHidden = false
        }
    }
    
    func hideError() {
        UIView.animate(withDuration: Constant.expansionDuration) { [weak errorLabelContainer] in
            errorLabelContainer?.isHidden = true
        }
    }
}
