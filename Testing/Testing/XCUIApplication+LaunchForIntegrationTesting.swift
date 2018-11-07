//
//  XCUIApplication+Launch.swift
//  TestAutomationExampleIntegrationTests
//
//  Created by Bartłomiej Nowak on 08/10/2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import XCTest

extension XCUIApplication {
    
    func launchForIntegrationTesting(withParameters parameters: [String: String]) {
        launchEnvironment["IntegrationTests"] = "true"
        parameters.forEach { key, value in launchEnvironment[key] = value }
        launch()
    }
}
