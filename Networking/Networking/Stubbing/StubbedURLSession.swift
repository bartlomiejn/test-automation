//
//  StubbedURLSession.swift
//  redux-swift
//
//  Created by Bartłomiej Nowak on 06.05.2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import Foundation

class StubbedURLSession: URLSession
{
    class DummyURLSessionDataTask: URLSessionDataTask
    {
        override func resume() {}
    }
    
    private let body: Data?
    private let response: HTTPURLResponse
    
    init(body: Data?, response: HTTPURLResponse)
    {
        self.body = body
        self.response = response
    }
    
    override func dataTask(
        with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask {
        completionHandler(body, response, nil)
        return DummyURLSessionDataTask()
    }
}
