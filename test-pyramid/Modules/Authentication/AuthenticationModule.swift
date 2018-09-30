//
//  AuthenticationModule.swift
//  TestPyramid
//
//  Created by Bartłomiej Nowak on 30/09/2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import UIKit

protocol AuthenticationModuleProtocol: class, AppModule {
    func authenticationSuccessful()
}

class AuthenticationModule: AuthenticationModuleProtocol {
    
    private weak var mainModule: MainModuleProtocol?
    private let httpClient: HTTPNetworkClient
    private let window: WindowProtocol
    
    init(mainModule: MainModuleProtocol, window: WindowProtocol, httpClient: HTTPNetworkClient) {
        self.mainModule = mainModule
        self.window = window
        self.httpClient = httpClient
    }
    
    func presentInitialView() {
        setupWindow(with: initialViewController())
    }
    
    func authenticationSuccessful() {
        mainModule?.presentAppView()
    }
    
    private func initialViewController() -> UIViewController {
        let viewController = UIStoryboard(name: "Authentication", bundle: Bundle(for: type(of: self)))
            .instantiateInitialViewController() as! AuthenticationViewController
        let navigationController = UINavigationController(rootViewController: viewController)
        let client = GitHubNetworkClient(client: httpClient)
        let service = AuthenticationService(client: client)
        let interactor = AuthenticationInteractor(service: service)
        let presenter = AuthenticationPresenter(view: viewController, module: self, interactor: interactor)
        viewController.presenter = presenter
        return navigationController
    }
    
    private func setupWindow(with viewController: UIViewController) {
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
}
