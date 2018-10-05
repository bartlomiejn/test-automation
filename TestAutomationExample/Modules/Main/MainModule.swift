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

class MainModule: MainModuleProtocol {
    
    var authenticationModule: AuthenticationModuleProtocol!
    var isRunningInTestMode = false
    private let window: WindowProtocol
    private let httpClient: HTTPNetworkClient
    
    init(window: WindowProtocol, httpClient: HTTPNetworkClient, isRunningInTestMode: Bool) {
        self.window = window
        self.httpClient = httpClient
        if isRunningInTestMode {
            AuthenticationStubGenerator(parameter: "success")?.injectStubs(into: httpClient)
        }
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
