//
//  APIErrorModel.swift
//  Networking
//
//  Created by Bartłomiej Nowak on 19/11/2018.
//  Copyright © 2018 Bartlomiej Nowak. All rights reserved.
//

import Foundation

public struct APIErrorModel
{
    public struct Response: Codable
    {
        public let message: String
    }
    
    public let statusCode: Int
    public let response: Response?
}
