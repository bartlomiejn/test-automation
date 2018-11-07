//
//  AuthenticationViewFactory.swift
//  TestAutomationExample
//
//  Created by Bartomiej Nowak on 07/11/2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import UIKit

protocol AuthenticationViewFactoryProtocol {
    func authentication() -> UIViewController
}

class AuthenticationViewFactory: AuthenticationViewFactoryProtocol {
    
    private let router: RouterProtocol
    private let networkClient: GitHubNetworkClient
    
    init(router: RouterProtocol, networkClient: GitHubNetworkClient) {
        self.router = router
        self.networkClient = networkClient
    }
    
    func authentication() -> UIViewController {
        let viewController = UIStoryboard(name: "Authentication", bundle: Bundle(for: type(of: self)))
            .instantiateInitialViewController() as! AuthenticationViewController
        let service = AuthenticationService(client: networkClient)
        let interactor = AuthenticationInteractor(service: service)
        let presenter = AuthenticationPresenter(router: router, view: viewController, interactor: interactor)
        viewController.presenter = presenter
        return UINavigationController(rootViewController: viewController)
    }
}
