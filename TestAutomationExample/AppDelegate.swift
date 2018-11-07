//
//  AppDelegate.swift
//  test-pyramid
//
//  Created by Bartłomiej Nowak on 22.09.2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import Core
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var mainContainer: MainDependencyContainer!
    var router: RouterProtocol!
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UIViewController()
        window?.makeKeyAndVisible()
        mainContainer = MainDependencyContainer(
            application: application,
            environmentVariables: ProcessInfo.processInfo.environment
        )
        router = mainContainer.router
        router.open(MainModule.self, parameters: [Parameter.path: MainModule.Path.initial], callback: nil)
        return true
    }
}
