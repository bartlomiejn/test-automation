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
    
    // MARK: Auth Success
    
    func test_GivenCredentialsAndSuccess_WhenTappedSignIn_ThenEnableSignInButton() {
        setFakeUsernameAndPassword()
        presenter.tappedSignIn()
        XCTAssertEqual(mockView.spyEnableSignInButtonCount, 1)
    }
    
    func test_GivenCredentialsAndSuccess_WhenTappedSignIn_ThenHideSpinner() {
        setFakeUsernameAndPassword()
        presenter.tappedSignIn()
        XCTAssertEqual(mockView.spyHideSpinnerCount, 1)
    }
    
    func test_GivenCredentialsAndSuccess_WhenTappedSignIn_ThenAuthSuccessful() {
        setFakeUsernameAndPassword()
        presenter.tappedSignIn()
        XCTAssertEqual(mockModule.spyAuthenticationSuccessfulCount, 1)
    }
    
    // MARK: Auth Failure
    
    func test_GivenCredentialsAndFailure_WhenTappedSignIn_ThenEnableSignInButton() {
        setFakeUsernameAndPassword()
        presenter.tappedSignIn()
        XCTAssertEqual(mockView.spyEnableSignInButtonCount, 1)
    }
    
    func test_GivenCredentialsAndFailure_WhenTappedSignIn_ThenHideSpinner() {
        setFakeUsernameAndPassword()
        presenter.tappedSignIn()
        XCTAssertEqual(mockView.spyHideSpinnerCount, 1)
    }
    
    func test_GivenCredentialsAndFailure_WhenTappedSignIn_ThenShowUnrecoverableError() {
        setFakeUsernameAndPassword(willAuthFail: true)
        presenter.tappedSignIn()
        XCTAssertEqual(mockView.spyShowErrors.first, "Unrecoverable error.")
    }
    
    // MARK: - Auxiliary
    
    private func setFakeUsernameAndPassword(willAuthFail: Bool = false) {
        presenter.usernameChanged(to: "FakeUsername")
        presenter.passwordChanged(to: "FakePassword")
        if willAuthFail {
            mockInteractor.mockSignInSuccess = false
            mockInteractor.mockSignInError = .unrecoverable
        }
    }
}

class MockAuthenticationView: AuthenticationViewInterface {

    private (set) var spyDisableSignInButtonCount = 0
    private (set) var spyEnableSignInButtonCount = 0
    private (set) var spyHideErrorCount = 0
    private (set) var spyShowSpinnerCount = 0
    private (set) var spyHideSpinnerCount = 0
    private (set) var spyShowErrors = [String]()
    
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
    
    func hideSpinner() {
        spyHideSpinnerCount += 1
    }
    
    func showError(description: String) {
        spyShowErrors.append(description)
    }
    
    func hideError() {
        spyHideErrorCount += 1
    }
}

class MockAuthenticationModule: AuthenticationModuleProtocol {
    
    private (set) var spyAuthenticationSuccessfulCount = 0
    
    func authenticationSuccessful() {
        spyAuthenticationSuccessfulCount += 1
    }
    
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
