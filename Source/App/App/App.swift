//
//  App.swift
//  App
//
//  Created by Bartomiej Nowak on 07/11/2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import Core
import Networking
import Authentication
import Main

class App
{
    let main: MainModule
    let authentication: AuthenticationModule
    private let application: ApplicationProtocol
    private let navigator: Navigator
    private let httpNetworkClient: HTTPNetworkClient
    private let networkClient: GitHubNetworkClient
    
    init(application: ApplicationProtocol, environmentVariables: [String: String])
    {
        self.application = application
        self.navigator = Navigator(application: application)
        self.httpNetworkClient = HTTPNetworkClient(timeoutInterval: 60.0, generator: URLGenerator())
        self.networkClient = GitHubNetworkClient(
            client: httpNetworkClient,
            tokenGenerator: BasicAuthTokenGenerator()
        )
        self.authentication = AuthenticationModule(
            navigator: navigator,
            viewFactory: AuthenticationViewFactory(networkClient: networkClient)
        )
        self.main = MainModule(navigator: navigator, authentication: authentication)
        authentication.delegate = main
        setupStubsIfNeeded(from: environmentVariables)
    }
    
    private func setupStubsIfNeeded(from environmentVariables: [String: String])
    {
        if isRunningIntegrationTests(from: environmentVariables) {
            AppStubGenerator(from: environmentVariables).injectStubs(into: httpNetworkClient)
        }
    }
    
    private func isRunningIntegrationTests(from environmentVariables: [String: String]) -> Bool
    {
        return environmentVariables["IntegrationTests"] == "true"
    }
}
