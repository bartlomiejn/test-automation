//
//  Router.swift
//  TestAutomationExample
//
//  Created by Bartomiej Nowak on 06/11/2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import Foundation

protocol RouterProtocol: AnyObject {
    func open(_ module: ModuleProtocol.Type, parameters: StringDictionary?, callback: ((StringDictionary?) -> Void)?)
    func open(_ url: URL, callback: ((StringDictionary?) -> Void)?)
}

class Router: RouterProtocol {
    
    private let navigator: NavigatorProtocol
    private let moduleManager: ModuleManagerProtocol
    
    init(navigator: NavigatorProtocol, moduleManager: ModuleManagerProtocol) {
        self.navigator = navigator
        self.moduleManager = moduleManager
    }
    
    func open(_ module: ModuleProtocol.Type, parameters: StringDictionary?, callback: ((StringDictionary?) -> Void)?) {
        guard
            let applicationScheme = applicationScheme(),
            let moduleUrl = URL(
                schema: applicationScheme,
                host: module.route,
                path: parameters?[Parameter.path],
                parameters: parameters
            )
        else {
            return
        }
        open(moduleUrl, callback: callback)
    }
    
    func open(_ url: URL, callback: ((StringDictionary?) -> Void)?) {
        guard let scheme = url.scheme else {
            return
        }
        if scheme == applicationScheme() {
            openModule(from: url, callback: callback)
        } else {
            callback?(nil)
        }
    }
    
    private func applicationScheme() -> String? {
        guard let URLTypes = Bundle.main.object(
            forInfoDictionaryKey: "CFBundleURLTypes"
        ) as? [[String: AnyObject]] else {
            return nil
        }
        let schemaString = URLTypes.reduce("") { _, dictionary -> String? in
            let schemes = dictionary.filter { $0.key == "CFBundleURLSchemes" }
            return (schemes.first?.value as? [String])?.last
        }
        return schemaString
    }
    
    private func openModule(from url: URL, callback: ((StringDictionary?) -> Void)?) {
        guard
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false),
            let route = components.host
        else {
            return
        }
        DispatchQueue.main.async {
            self.moduleManager.getModule(for: route)?.open(
                path: components.path,
                parameters: components.queryItemsDictionary,
                callback: callback
            )
        }
    }
}
