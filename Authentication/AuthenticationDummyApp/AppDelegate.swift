//
//  AppDelegate.swift
//  AuthenticationDummyApp
//
//  Created by Bartomiej Nowak on 07/11/2018.
//  Copyright © 2018 Bartlomiej Nowak. All rights reserved.
//

import Core
import Networking
import Authentication
import UIKit

class DummyRouter: RouterProtocol {
    func open(_ module: ModuleProtocol.Type, parameters: StringDictionary?, callback: ((StringDictionary?) -> Void)?) {}
    func open(_ url: URL, callback: ((StringDictionary?) -> Void)?) {}
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var module: AuthenticationModule!
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        setupWindow()
        let networkClient = HTTPNetworkClient(timeoutInterval: 60.0)
        module = authenticationModule(application: application, networkClient: networkClient)
        module.open(path: nil, parameters: nil, callback: nil)
        return true
    }
    
    private func setupWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = {
            let controller = UIViewController()
            controller.view.backgroundColor = .white
            return controller
        }()
        window?.makeKeyAndVisible()
    }
    
    private func authenticationModule(
        application: UIApplication,
        networkClient: HTTPNetworkClient
    ) -> AuthenticationModule {
        let router = DummyRouter()
        let networkClient = HTTPNetworkClient(timeoutInterval: 60.0)
        let gitHubClient = GitHubNetworkClient(client: networkClient)
        let viewFactory = AuthenticationViewFactory(router: router, networkClient: gitHubClient)
        let module = AuthenticationModule(router: router, navigator: Navigator(application: application))
        module.viewFactory = viewFactory
        return module
    }
}
