//
//  AuthenticationPresenterTests.swift
//  TestAutomationExampleTests
//
//  Created by Bartłomiej Nowak on 05/10/2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import XCTest
@testable import TestAutomationExample

final class AuthenticationPresenterTests: XCTestCase {
    
    private var presenter: AuthenticationPresenter!
    private var mockView: MockAuthenticationView!
    private var mockModule: MockAuthenticationModule!
    private var mockInteractor: MockAuthenticationInteractor!
    
    override func setUp() {
        super.setUp()
        mockView = MockAuthenticationView()
        mockModule = MockAuthenticationModule()
        mockInteractor = MockAuthenticationInteractor()
        presenter = AuthenticationPresenter(view: mockView, module: mockModule, interactor: mockInteractor)
    }
    
    override func tearDown() {
        presenter = nil
        mockView = nil
        mockModule = nil
        mockInteractor = nil
        super.tearDown()
    }
    
    // MARK: - tappedSignIn()
    
    func test_GivenNoUsernameAndPassword_WhenTappedSignIn_ThenDontSignIn() {
        presenter.tappedSignIn()
        XCTAssertEqual(mockInteractor.spySignInCount, 0)
    }
    
    func test_GivenCredentials_WhenTappedSignIn_ThenDisableSignInButton() {
        setFakeUsernameAndPassword()
        presenter.tappedSignIn()
        XCTAssertEqual(mockView.spyDisableSignInButtonCount, 1)
    }
    
    func test_GivenCredentials_WhenTappedSignIn_ThenHideError() {
        setFakeUsernameAndPassword()
        presenter.tappedSignIn()
        XCTAssertEqual(mockView.spyHideErrorCount, 1)
    }
    
    func test_GivenCredentials_WhenTappedSignIn_ThenShowSpinner() {
        setFakeUsernameAndPassword()
        presenter.tappedSignIn()
        XCTAssertEqual(mockView.spyShowSpinnerCount, 1)
    }
    
    func test_GivenCredentials_WhenTappedSignIn_ThenSignIn() {
        setFakeUsernameAndPassword()
        presenter.tappedSignIn()
        XCTAssertEqual(mockInteractor.spySignInCount, 1)
    }
    
    func test_GivenCredentialsAndSuccess_WhenTappedSignIn_ThenEnableSignInButton() {
        setFakeUsernameAndPassword()
        presenter.tappedSignIn()
        XCTAssertEqual(mockView.spyEnableSignInButtonCount, 1)
    }
    
    private func setFakeUsernameAndPassword() {
        presenter.usernameChanged(to: "FakeUsername")
        presenter.passwordChanged(to: "FakePassword")
    }
}

class MockAuthenticationView: AuthenticationViewInterface {

    private (set) var spyDisableSignInButtonCount = 0
    private (set) var spyEnableSignInButtonCount = 0
    private (set) var spyHideErrorCount = 0
    private (set) var spyShowSpinnerCount = 0
    
    func enableSignInButton() {
        spyEnableSignInButtonCount += 1
    }

    func disableSignInButton() {
        spyDisableSignInButtonCount += 1
    }
    
    func show(username: String) {}
    
    func show(password: String) {}
    
    func showSpinner() {
        spyShowSpinnerCount += 1
    }
    
    func hideSpinner() {}
    
    func showError(description: String) {}
    
    func hideError() {
        spyHideErrorCount += 1
    }
}

class MockAuthenticationModule: AuthenticationModuleProtocol {
    
    func authenticationSuccessful() {}
    
    func presentInitialView() {}
}

class MockAuthenticationInteractor: AuthenticationInteractorInterface {
    
    var mockSignInSuccess = true
    var mockSignInError = AuthenticationError.unrecoverable
    private (set) var spySignInCount = 0
    
    func signIn(
        username: String,
        password: String,
        success: @escaping () -> Void,
        failure: @escaping AuthenticationErrorClosure
    ) {
        spySignInCount += 1
        if mockSignInSuccess {
            success()
        } else {
            failure(mockSignInError)
        }
    }
}
