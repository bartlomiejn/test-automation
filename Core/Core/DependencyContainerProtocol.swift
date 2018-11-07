//
//  DependencyContainerProtocol.swift
//  Core
//
//  Created by Bartomiej Nowak on 07/11/2018.
//  Copyright © 2018 Bartlomiej Nowak. All rights reserved.
//

import Foundation

public protocol DependencyContainerProtocol {
    func injectDependencies<T>(into object: T)
}
