//
//  AuthenticationTests.swift
//  TestAutomationExampleEndToEndTests
//
//  Created by Bartłomiej Nowak on 22.09.2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import XCTest

class AuthenticationPage: PageObject {
    
    override var element: XCUIElement {
        return signInButton
    }
    
    var signInButton: XCUIElement {
        return app.buttons["signin_button"]
    }
}

class PageObject {
    
    let app: XCUIApplication
    
    var element: XCUIElement {
        fatalError("Implement in a subclass.")
    }
    
    init?(app: XCUIApplication, existenceTimeout: TimeInterval = 10.0, assertPageElementExists: Bool = true) {
        self.app = app
        let doesPageExist = element.waitForExistence(timeout: existenceTimeout)
        if assertPageElementExists {
            XCTAssertTrue(doesPageExist)
        }
        if !doesPageExist {
            return nil
        }
    }
}

class AuthenticationTests: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func testExample() {
        app.buttons["signin_button"].tap()
        wait(for: [], timeout: 10.0)
    }
}
