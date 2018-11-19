//
//  UITestsApplicationProtocol.swift
//  Shared test files
//
//  Created by Bartomiej Nowak on 08/11/2018.
//  Copyright © 2018 Bartlomiej Nowak. All rights reserved.
//

import XCTest

extension XCUIApplication
{
    func launchForIntegrationTesting(withParameters parameters: [String: String])
    {
        launchEnvironment["IntegrationTests"] = "true"
        parameters.forEach { key, value in launchEnvironment[key] = value }
        launch()
    }
}
