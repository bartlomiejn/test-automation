//
//  ModuleManager.swift
//  TestAutomationExample
//
//  Created by Bartomiej Nowak on 07/11/2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import Foundation

protocol DependencyContainerProtocol {
    func injectDependencies<T>(into object: T)
}

protocol ModuleManagerProtocol: AnyObject {
    func register(_ moduleType: ModuleProtocol.Type)
    func register(_ moduleType: ModuleProtocol.Type, with dependencyContainer: DependencyContainerProtocol)
    func getModule(for route: Route) -> ModuleProtocol?
    func get(_ moduleType: ModuleProtocol.Type) -> ModuleProtocol
}

class ModuleManager: ModuleManagerProtocol {
    
    var router: RouterProtocol!
    private let navigator: NavigatorProtocol
    private var moduleTypes = [ModuleProtocol.Type]()
    private var modules = [Route: ModuleProtocol]()
    private var dependencyContainers = [Route: DependencyContainerProtocol]()
    private let queue = DispatchQueue(label: "Private Router DispatchQueue")
    
    init(navigator: NavigatorProtocol) {
        self.navigator = navigator
    }
    
    func register(_ moduleType: ModuleProtocol.Type) {
        moduleTypes.append(moduleType)
    }
    
    func register(_ moduleType: ModuleProtocol.Type, with dependencyContainer: DependencyContainerProtocol) {
        register(moduleType)
        dependencyContainers[moduleType.route] = dependencyContainer
    }
    
    func getModule(for route: Route) -> ModuleProtocol? {
        if let moduleType = moduleTypes.first(where: { $0.route == route }) {
            return get(moduleType)
        } else {
            return nil
        }
    }
    
    func get(_ moduleType: ModuleProtocol.Type) -> ModuleProtocol {
        if let module = getModule(for: moduleType.route) {
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
