//
//  AppDelegate.swift
//  test-pyramid
//
//  Created by Bartłomiej Nowak on 22.09.2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var httpClient: HTTPNetworkClient!
    var mainModule: MainModule!
    var authenticationModule: AuthenticationModule!
    
    var environmentVariables: [String: String] {
        return ProcessInfo.processInfo.environment
    }
    var isAppRunningInTestMode: Bool {
        return environmentVariables["XCInjectBundleInto"] != nil
    }

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        httpClient = HTTPNetworkClient(timeoutInterval: 60.0)
        if isAppRunningInTestMode {
            AppStubGenerator(from: environmentVariables).injectStubs(into: httpClient)
        }
        mainModule = MainModule(window: window!, httpClient: httpClient)
        mainModule.authenticationModule = AuthenticationModule(
            mainModule: mainModule!,
            window: window!,
            httpClient: httpClient
        )
        mainModule.presentInitialView()
        return true
    }
    

}
