//
//  AuthenticationDependencyContainer.swift
//  TestAutomationExample
//
//  Created by Bartomiej Nowak on 07/11/2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import Foundation

class AuthenticationDependencyContainer: DependencyContainerProtocol {
    
    private let router: RouterProtocol
    private let networkClient: GitHubNetworkClient
    
    init(router: RouterProtocol, networkClient: GitHubNetworkClient) {
        self.router = router
        self.networkClient = networkClient
    }
    
    func injectDependencies<T>(into object: T) {
        if let module = object as? AuthenticationModule {
            inject(module)
        }
    }
    
    private func inject(_ module: AuthenticationModule) {
        module.viewFactory = AuthenticationViewFactory(router: router, networkClient: networkClient)
    }
}
