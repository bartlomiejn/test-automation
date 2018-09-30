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
    var authenticationModule: AuthenticationModule!
    
    var isAppRunningInTestMode: Bool {
        return ProcessInfo.processInfo.environment["XCInjectBundleInto"] != nil
    }
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        httpClient = HTTPNetworkClient(timeoutInterval: 60.0)
        authenticationModule = AuthenticationModule(window: window!, httpClient: httpClient)
        authenticationModule.isRunningInTestMode = isAppRunningInTestMode
        authenticationModule.presentInitialView()
        return true
    }
    

}
