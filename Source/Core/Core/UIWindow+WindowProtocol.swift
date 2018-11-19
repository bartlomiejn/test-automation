//
//  UIWindow+WindowProtocol.swift
//  Core
//
//  Created by Bartłomiej Nowak on 30/09/2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import UIKit

public protocol WindowProtocol: class
{
    var rootViewController: UIViewController? { get set }
    func makeKeyAndVisible()
}

extension UIWindow: WindowProtocol {}
