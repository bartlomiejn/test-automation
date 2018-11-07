//
//  MainPage.swift
//  TestAutomationExampleIntegrationTests
//
//  Created by Bartłomiej Nowak on 08/10/2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import XCTest

public class MainPage: PageObject {
    
    public override var identyfingElement: XCUIElement {
        return app.images.firstMatch
    }
}
