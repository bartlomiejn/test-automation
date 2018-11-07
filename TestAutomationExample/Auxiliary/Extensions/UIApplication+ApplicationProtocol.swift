//
//  UIApplication+ApplicationProtocol.swift
//  TestAutomationExample
//
//  Created by Bartomiej Nowak on 06/11/2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import UIKit

protocol ApplicationProtocol: AnyObject {
    var keyWindow: UIWindow? { get }
}

extension UIApplication: ApplicationProtocol {}
