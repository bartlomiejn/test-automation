//
//  ModuleProtocol.swift
//  TestPyramid
//
//  Created by Bartłomiej Nowak on 30/09/2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import Foundation

protocol ModuleProtocol {
    static var route: Route { get }
    init(router: RouterProtocol, navigator: NavigatorProtocol)
    func open(path: String?, parameters: StringDictionary?, callback: ((StringDictionary?) -> Void)?)
}
