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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    var window: UIWindow?
    var module: AuthenticationModule!
    var navigator: Navigator!
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        setupWindow()
        navigator = Navigator(application: application)
        module = authenticationModule(
            navigator: navigator,
            networkClient: networkClient(with: ProcessInfo.processInfo.environment)
        )
        module.delegate = self
        module.show()
        return true
    }
    
    private func setupWindow()
    {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = {
            let controller = UIViewController()
            controller.view.backgroundColor = .white
            return controller
        }()
        window?.makeKeyAndVisible()
    }
    
    private func networkClient(with environmentVariables: [String: String]) -> HTTPNetworkClient
    {
        let networkClient = HTTPNetworkClient(timeoutInterval: 60.0)
        if environmentVariables["IntegrationTests"] == "true" {
            AuthenticationStubGenerator(from: environmentVariables).injectStubs(into: networkClient)
        }
        return networkClient
    }
    
    private func authenticationModule(
        navigator: Navigator,
        networkClient: HTTPNetworkClient
    ) -> AuthenticationModule {
        let gitHubClient = GitHubNetworkClient(client: networkClient)
        let viewFactory = AuthenticationViewFactory(networkClient: gitHubClient)
        return AuthenticationModule(navigator: navigator, viewFactory: viewFactory)
    }
}

extension AppDelegate: AuthenticationModuleDelegate
{
    func authenticationSuccess()
    {
        navigator.present(as: .navigationStack, controller: fakeSuccessController())
    }
    
    private func fakeSuccessController() -> UIViewController
    {
        return {
            let controller = UIViewController()
            controller.view.backgroundColor = .white
            let label = UILabel()
            label.text = "Main module"
            label.accessibilityIdentifier = "pushed_fake_view"
            controller.view.addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                controller.view.topAnchor.constraint(equalTo: label.safeAreaLayoutGuide.topAnchor),
                controller.view.leadingAnchor.constraint(equalTo: label.leadingAnchor)
            ])
            return controller
        }()
    }
}
