//
//  UIApplication+ApplicationProtocol.swift
//  Core
//
//  Created by Bartomiej Nowak on 06/11/2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import UIKit

public protocol ApplicationProtocol: AnyObject
{
    var keyWindow: UIWindow? { get }
}

extension UIApplication: ApplicationProtocol {}
