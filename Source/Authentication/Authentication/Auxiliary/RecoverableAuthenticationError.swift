//
//  RecoverableAuthenticationError.swift
//  Authentication
//
//  Created by Bartłomiej Nowak on 19/11/2018.
//  Copyright © 2018 Bartlomiej Nowak. All rights reserved.
//

import Foundation

enum RecoverableAuthenticationError
{
    case invalidCredentials
    case response(message: String?)
}
