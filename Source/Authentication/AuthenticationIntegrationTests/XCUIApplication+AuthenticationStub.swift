//
//  XCUIApplication+AuthenticationStub.swift
//  TestAutomationExampleIntegrationTests
//
//  Created by Bartłomiej Nowak on 08/10/2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import XCTest

extension XCUIApplication
{
    func launchForIntegrationTesting(withAuthenticationStub stubName: String)
    {
        launchForIntegrationTesting(withParameters: ["auth": stubName])
    }
}
