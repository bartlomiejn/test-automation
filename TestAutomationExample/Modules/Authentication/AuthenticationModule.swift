//
//  AuthenticationModule.swift
//  TestPyramid
//
//  Created by Bartłomiej Nowak on 30/09/2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import UIKit

protocol AuthenticationModuleProtocol: AnyObject, ModuleProtocol {
    func authenticationSuccessful()
}

class AuthenticationModule: AuthenticationModuleProtocol {
    
    static let route = "auth"
    private let router: RouterProtocol
    private let navigator: NavigatorProtocol
    var viewFactory: AuthenticationViewFactory!
    
    // MARK: - ModuleProtocol
    
    required init(router: RouterProtocol, navigator: NavigatorProtocol) {
        self.router = router
        self.navigator = navigator
    }
    
    func open(path: String?, parameters: StringDictionary?, callback: ((StringDictionary?) -> Void)?) {
        navigator.present(as: .root, controller: viewFactory.authentication())
        callback?(nil)
    }
    
    // MARK: - AuthenticationModuleProtocol
    
    func authenticationSuccessful() {
        router.open(MainModule.self, parameters: [Parameter.path: MainModule.Path.app], callback: nil)
    }
}
