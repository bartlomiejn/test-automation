//
//  AuthenticationViewFactory.swift
//  Authentication
//
//  Created by Bartomiej Nowak on 07/11/2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import Core
import Networking
import UIKit

public protocol AuthenticationViewFactoryProtocol
{
    func authentication(module: AuthenticationModuleProtocol) -> UIViewController
}

public class AuthenticationViewFactory
{
    private enum Storyboard
    {
        static let id = "Authentication"
    }
    private let networkClient: GitHubNetworkClient
    
    public init(networkClient: GitHubNetworkClient)
    {
        self.networkClient = networkClient
    }
}

extension AuthenticationViewFactory: AuthenticationViewFactoryProtocol
{
    public func authentication(module: AuthenticationModuleProtocol) -> UIViewController
    {
        let viewController = UIStoryboard(name: Storyboard.id, bundle: Bundle(for: type(of: self)))
            .instantiateInitialViewController() as! AuthenticationViewController
        let service = AuthenticationService(client: networkClient)
        let interactor = AuthenticationInteractor(service: service)
        let presenter = AuthenticationPresenter(module: module, view: viewController, interactor: interactor)
        viewController.presenter = presenter
        return UINavigationController(rootViewController: viewController)
    }
}
