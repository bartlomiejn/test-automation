//
//  AuthenticationModule.swift
//  Authentication
//
//  Created by Bartłomiej Nowak on 30/09/2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import Core
import UIKit

public protocol AuthenticationModuleDelegate: AnyObject
{
    func authenticationSuccess()
}

public protocol AuthenticationModuleProtocol: AnyObject
{
    func show()
    func success()
}

public class AuthenticationModule
{
    public weak var delegate: AuthenticationModuleDelegate?
    private let navigator: NavigatorProtocol
    private let viewFactory: AuthenticationViewFactoryProtocol
    
    public required init(navigator: NavigatorProtocol, viewFactory: AuthenticationViewFactoryProtocol){
        self.navigator = navigator
        self.viewFactory = viewFactory
    }
}

extension AuthenticationModule: AuthenticationModuleProtocol
{
    public func show()
    {
        navigator.present(as: .root, controller: viewFactory.authentication(module: self))
    }
    
    public func success()
    {
        delegate?.authenticationSuccess()
    }
}
