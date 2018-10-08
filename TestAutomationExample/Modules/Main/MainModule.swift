//
//  MainModule.swift
//  TestPyramid
//
//  Created by Bartłomiej Nowak on 30/09/2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import UIKit

protocol MainModuleProtocol: class, ModuleProtocol {
    func presentAppView()
}

struct AppConfiguration {
    let isRunningInTestMode: Bool
    let launchParameters: [String: String]
}

class MainModule: MainModuleProtocol {
    
    var authenticationModule: AuthenticationModuleProtocol!
    private let window: WindowProtocol
    private let httpClient: HTTPNetworkClient
    
    init(window: WindowProtocol, httpClient: HTTPNetworkClient) {
        self.window = window
        self.httpClient = httpClient
    }
    
    func presentInitialView() {
        authenticationModule.presentInitialView()
    }
    
    func presentAppView() {
        let viewController = UIStoryboard(name: "Main", bundle: Bundle(for: type(of: self)))
            .instantiateInitialViewController()!
        (window.rootViewController as? UINavigationController)?.pushViewController(viewController, animated: true)
    }
}
