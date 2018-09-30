//
//  AuthenticationModule.swift
//  TestPyramid
//
//  Created by Bartłomiej Nowak on 30/09/2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import UIKit

protocol AppModule {
    func presentInitialView()
}

class AuthenticationModule: AppModule {
    
    private let httpClient: HTTPNetworkClient
    private let window: UIWindow
    
    var isRunningInTestMode = false
    
    init(window: UIWindow, httpClient: HTTPNetworkClient) {
        self.httpClient = httpClient
        self.window = window
    }
    
    func presentInitialView() {
        setupWindow(with: initialViewController())
    }
    
    private func initialViewController() -> AuthenticationViewController {
        if isRunningInTestMode {
            AuthenticationStubGenerator(parameter: "success")?.injectStubs(into: httpClient)
        }
        let viewController = UIStoryboard(name: "Authentication", bundle: Bundle(for: type(of: self)))
            .instantiateInitialViewController() as! AuthenticationViewController
        let client = GitHubNetworkClient(client: httpClient)
        let service = AuthenticationService(client: client)
        let interactor = AuthenticationInteractor(service: service)
        let presenter = AuthenticationPresenter(view: viewController, interactor: interactor)
        viewController.presenter = presenter
        return viewController
    }
    
    private func setupWindow(with viewController: UIViewController) {
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
}
