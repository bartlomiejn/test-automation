//
//  ModuleManager.swift
//  TestAutomationExample
//
//  Created by Bartomiej Nowak on 07/11/2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import Foundation

public protocol ModuleManagerProtocol: AnyObject {
    func register(_ moduleType: ModuleProtocol.Type)
    func register(_ moduleType: ModuleProtocol.Type, with dependencyContainer: DependencyContainerProtocol)
    func getModule(for route: Route) -> ModuleProtocol?
    func get(_ moduleType: ModuleProtocol.Type) -> ModuleProtocol
}

public class ModuleManager: ModuleManagerProtocol {
    
    public var router: RouterProtocol!
    private let navigator: NavigatorProtocol
    private var moduleTypes = [ModuleProtocol.Type]()
    private var modules = [Route: ModuleProtocol]()
    private var dependencyContainers = [Route: DependencyContainerProtocol]()
    private let queue = DispatchQueue(label: "Private Router DispatchQueue")
    
    public init(navigator: NavigatorProtocol) {
        self.navigator = navigator
    }
    
    public func register(_ moduleType: ModuleProtocol.Type) {
        moduleTypes.append(moduleType)
    }
    
    public func register(_ moduleType: ModuleProtocol.Type, with dependencyContainer: DependencyContainerProtocol) {
        register(moduleType)
        dependencyContainers[moduleType.route] = dependencyContainer
    }
    
    public func getModule(for route: Route) -> ModuleProtocol? {
        if let moduleType = moduleTypes.first(where: { $0.route == route }) {
            return get(moduleType)
        } else {
            return nil
        }
    }
    
    public func get(_ moduleType: ModuleProtocol.Type) -> ModuleProtocol {
        if let module = modules[moduleType.route] {
            return module
        } else {
            let module = moduleType.init(router: router, navigator: navigator)
            dependencyContainers[moduleType.route]?.injectDependencies(into: module)
            add(module)
            return module
        }
    }
    
    private func module(for route: Route) -> ModuleProtocol? {
        var module: ModuleProtocol?
        queue.sync { [weak self] in
            module = self?.modules[route]
        }
        return module
    }
    
    private func add(_ module: ModuleProtocol) {
        queue.sync {
            modules[type(of: module).route] = module
        }
    }
}
