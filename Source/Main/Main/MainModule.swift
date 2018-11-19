//
//  MainModule.swift
//  Main
//
//  Created by Bartłomiej Nowak on 30/09/2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import UIKit
import Core
import Authentication

public protocol MainModuleProtocol: AnyObject {
    func show()
}

public final class MainModule
{
    private enum Storyboard
    {
        static let id = "Main"
    }
    private let navigator: NavigatorProtocol
    private let authentication: AuthenticationModuleProtocol
    
    public required init(navigator: NavigatorProtocol, authentication: AuthenticationModuleProtocol)
    {
        self.navigator = navigator
        self.authentication = authentication
    }
}

extension MainModule: MainModuleProtocol
{
    public func show()
    {
        authentication.show()
    }
}

extension MainModule: AuthenticationModuleDelegate
{
    public func authenticationSuccess()
    {
        showApp()
    }
    
    private func showApp()
    {
        let controller = UIStoryboard(
            name: Storyboard.id,
            bundle: Bundle(for: type(of: self))
        ).instantiateInitialViewController()!
        navigator.present(as: .navigationStack, controller: controller)
    }
}
