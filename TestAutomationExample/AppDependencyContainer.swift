//
//  MainDependencyContainer.swift
//  TestAutomationExample
//
//  Created by Bartomiej Nowak on 07/11/2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import Core
import Networking
import Authentication

class AppDependencyContainer {
    
    lazy var authenticationContainer = AuthenticationDependencyContainer(router: router, networkClient: networkClient)
    lazy var router: RouterProtocol = Router(navigator: navigator, moduleManager: moduleManager)
    private let application: ApplicationProtocol
    private lazy var navigator = Navigator(application: application)
    private lazy var moduleManager = ModuleManager(navigator: navigator)
    private let httpNetworkClient = HTTPNetworkClient(timeoutInterval: 60.0, generator: URLGenerator())
    private lazy var networkClient = GitHubNetworkClient(
        client: httpNetworkClient,
        tokenGenerator: BasicAuthTokenGenerator()
    )
    
    init(application: ApplicationProtocol, environmentVariables: [String: String]) {
        self.application = application
        moduleManager.router = router
        setupStubsIfNeeded(from: environmentVariables)
        setupModuleTypes()
    }
    
    private func setupStubsIfNeeded(from environmentVariables: [String: String]) {
        if isRunningIntegrationTests(from: environmentVariables) {
            AppStubGenerator(from: environmentVariables).injectStubs(into: httpNetworkClient)
        }
    }
    
    private func setupModuleTypes() {
        moduleManager.register(MainModule.self)
        moduleManager.register(AuthenticationModule.self, with: authenticationContainer)
    }
    
    private func isRunningIntegrationTests(from environmentVariables: [String: String]) -> Bool {
        return environmentVariables["IntegrationTests"] == "true"
    }
}
