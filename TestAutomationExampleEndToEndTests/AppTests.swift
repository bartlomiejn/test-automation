//
//  AppTests.swift
//  TestAutomationExampleE2ETests
//
//  Created by Bartłomiej Nowak on 22.09.2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import XCTest

class AuthenticationTests: XCTestCase
{
    private enum Constant
    {
        static let success = "success"
        static let failure = "failure"
    }
    private enum Credentials
    {
        static let validUsername = "testauthexample"
        static let validPassword = "testauthexample123"
        static let invalidUsername = "i_hope_this_username_is_not_taken"
        static let invalidPassword = "with_this_password"
    }
    
    private var app: XCUIApplication!
    
    override func setUp()
    {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown()
    {
        app.terminate()
        app = nil
        super.tearDown()
    }
    
    func test_GivenSuccess_WhenSignIn_ThenShowSuccessPage()
    {
//        AuthenticationPage(assertingExistenceWithApp: app)?
//            .mainPageAfterSignIn(username: Credentials.validUsername, password: Credentials.validPassword)
    }
    
    func test_GivenUnauthorized_WhenSignIn_ThenStayOnAuthenticationPageAndShowError()
    {
//        AuthenticationPage(assertingExistenceWithApp: app)?
//            .signInWithCredentials(username: Credentials.invalidUsername, password: Credentials.invalidPassword)
//            .waitForErrorLabelAssertingExistence(timeout: 5.0)
    }
}
