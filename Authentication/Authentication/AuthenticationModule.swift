//
//  AuthenticationModule.swift
//  TestPyramid
//
//  Created by Bartłomiej Nowak on 30/09/2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import Core
import UIKit

public class AuthenticationModule: ModuleProtocol {
    
    enum Path {
        static let success = "/success"
    }
    public static let route = "auth"
    private let router: RouterProtocol
    private let navigator: NavigatorProtocol
    var viewFactory: AuthenticationViewFactory!
    
    public required init(router: RouterProtocol, navigator: NavigatorProtocol) {
        self.router = router
        self.navigator = navigator
    }
    
    public func open(path: String?, parameters: StringDictionary?, callback: ((StringDictionary?) -> Void)?) {
        switch path {
        case Path.success:
            router.open(URL(string: "modules://main/app_view")!, callback: nil)
        default:
            navigator.present(as: .root, controller: viewFactory.authentication())
        }
        callback?(nil)
    }
}
