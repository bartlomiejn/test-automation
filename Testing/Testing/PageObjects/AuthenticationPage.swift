//
//  AuthenticationPage.swift
//  TestAutomationExampleIntegrationTests
//
//  Created by Bartłomiej Nowak on 08/10/2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import XCTest

class AuthenticationPage: PageObject {

    override var identyfingElement: XCUIElement {
        return signInButton
    }
    var usernameField: XCUIElement {
        return app.textFields["username_field"]
    }
    var passwordField: XCUIElement {
        return app.secureTextFields["pass_field"]
    }
    var errorLabel: XCUIElement {
        return app.staticTexts["error_label"]
    }
    var signInButton: XCUIElement {
        return app.buttons["signin_button"]
    }
    
    @discardableResult
    func mainPageAfterSignIn(username: String, password: String) -> MainPage? {
        signInWithCredentials(username: username, password: password)
        return MainPage(assertingExistenceWithApp: app)
    }
    
    @discardableResult
    func signInWithCredentials(username: String, password: String) -> AuthenticationPage {
        usernameField.tap()
        usernameField.typeText(username)
        passwordField.tap()
        passwordField.typeText(password)
        signInButton.tap()
        return self
    }
    
    func waitForErrorLabelAssertingExistence(timeout: TimeInterval) {
        if !errorLabel.waitForExistence(timeout: 5.0) {
            XCTFail("Expected error label to be available.")
        }
    }
}
