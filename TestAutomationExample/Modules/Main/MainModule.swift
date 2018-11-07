//
//  MainModule.swift
//  TestPyramid
//
//  Created by Bartłomiej Nowak on 30/09/2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import UIKit

class MainModule: ModuleProtocol {

    enum Path {
        static let initial = "/initial_view"
        static let app = "/app_view"
    }
    static let route = "main"
    private let router: RouterProtocol
    private let navigator: NavigatorProtocol
    
    required init(router: RouterProtocol, navigator: NavigatorProtocol) {
        self.router = router
        self.navigator = navigator
    }
    
    func open(path: String?, parameters: StringDictionary?, callback: ((StringDictionary?) -> Void)?) {
        switch path {
        case Path.initial:
            router.open(AuthenticationModule.self, parameters: nil, callback: callback)
        case Path.app:
            presentAppView(callback: callback)
        default:
            callback?(nil)
        }
    }
    
    func presentAppView(callback: ((StringDictionary?) -> Void)?) {
        let viewController = UIStoryboard(name: "Main", bundle: Bundle(for: type(of: self)))
            .instantiateInitialViewController()!
        navigator.present(as: .navigationStack, controller: viewController)
        callback?(nil)
    }
}
