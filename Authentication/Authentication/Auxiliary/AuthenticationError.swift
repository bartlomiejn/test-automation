//
//  AuthenticationError.swift
//  Authentication
//
//  Created by Bartłomiej Nowak on 19/11/2018.
//  Copyright © 2018 Bartlomiej Nowak. All rights reserved.
//

import Foundation

enum AuthenticationError
{
    case recoverable(RecoverableAuthenticationError)
    case unrecoverable
}
