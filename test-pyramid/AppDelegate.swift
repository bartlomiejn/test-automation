//
//  AppDelegate.swift
//  test-pyramid
//
//  Created by Bartłomiej Nowak on 22.09.2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import UIKit

enum AuthenticationStub: String {
    case success
}

protocol StubGenerator {
    func injectStubs(into client: HTTPNetworkClient)
}

class AuthenticationStubGenerator: StubGenerator {
    
    let stub: AuthenticationStub
    
    init?(parameter: String) {
        guard let stub = AuthenticationStub(rawValue: parameter) else {
            return nil
        }
        self.stub = stub
    }
    
    func injectStubs(into client: HTTPNetworkClient) {
        switch stub {
        case .success:
            try! client.stub(AuthenticationService.Path.user, .GET, statusCode: 200, body: nil, headers: nil)
        }
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var httpClient: HTTPNetworkClient!
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
    ) -> Bool {
        httpClient = HTTPNetworkClient(timeoutInterval: 60.0)
        if isAppRunningInTestMode() {
            AuthenticationStubGenerator(parameter: "success")?.injectStubs(into: httpClient)
        }
        setupWindow(with: initialViewController())
        return true
    }
    
    private func isAppRunningInTestMode() -> Bool {
        return ProcessInfo.processInfo.environment["XCInjectBundleInto"] != nil
    }
    
    private func initialViewController() -> AuthenticationViewController {
        let viewController = UIStoryboard(name: "Authentication", bundle: Bundle(for: type(of: self)))
            .instantiateInitialViewController() as! AuthenticationViewController
        let client = GitHubNetworkClient(client: httpClient)
        let service = AuthenticationService(client: client)
        let interactor = AuthenticationInteractor(service: service)
        let presenter = AuthenticationPresenter(view: viewController, interactor: interactor)
        viewController.presenter = presenter
    }
    
    private func setupWindow(with viewController: UIViewController) {
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = viewController
        window!.makeKeyAndVisible()
    }
}
