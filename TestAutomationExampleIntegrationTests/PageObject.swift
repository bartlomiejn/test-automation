//
//  PageObject.swift
//  TestAutomationExampleIntegrationTests
//
//  Created by Bartłomiej Nowak on 08/10/2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import XCTest

class PageObject {
    
    let app: XCUIApplication
    
    var identyfingElement: XCUIElement {
        fatalError("Implement in a subclass.")
    }
    
    init?(
        assertingExistenceWithApp app: XCUIApplication,
        existenceTimeout: TimeInterval = 10.0,
        assertingPageElementExists: Bool = true
    ) {
        self.app = app
        let doesPageExist = identyfingElement.waitForExistence(timeout: existenceTimeout)
        if assertingPageElementExists {
            XCTAssert(identyfingElement.exists)
        }
        if !doesPageExist {
            return nil
        }
    }
}
