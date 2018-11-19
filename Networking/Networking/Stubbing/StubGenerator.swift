//
//  StubGenerator.swift
//  Networking
//
//  Created by Bartłomiej Nowak on 30/09/2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import Foundation

public protocol StubGenerator
{
    func injectStubs(into client: HTTPNetworkClient)
}
