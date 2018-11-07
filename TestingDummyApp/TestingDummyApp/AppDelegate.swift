//
//  AppDelegate.swift
//  TestingDummyApp
//
//  Created by Bartomiej Nowak on 07/11/2018.
//  Copyright © 2018 Bartlomiej Nowak. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = {
            let controller = UIViewController()
            controller.view.backgroundColor = .white
            return controller
        }()
        window?.makeKeyAndVisible()
        return true
    }
}

