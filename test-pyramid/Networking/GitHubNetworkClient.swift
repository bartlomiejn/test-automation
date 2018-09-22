//
//  GitHubNetworkClient.swift
//  redux-swift
//
//  Created by Bartłomiej Nowak on 06.05.2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import Foundation

struct Unauthorized: Error {}
struct InvalidResponse: Error {}
struct GitHubAPIError: Error {
    struct Response: Codable {
        let message: String
    }
    
    let statusCode: Int
    let response: Response?
}

protocol GitHubNetworkClientInterface {
    func request(
        _ method: HTTPMethod,
        path: String,
        successCallback: @escaping (Data?) -> Void,
        failureCallback: ((Error?) -> Void)?
    )
    func setBasicAuthToken(username: String, password: String) throws
}

final class GitHubNetworkClient: GitHubNetworkClientInterface {
    
    private struct Constant {
        static let userAgent = "User-Agent"
        static let authorization = "Authorization"
        static let userAgentValue = "bartlomiejn/test-pyramid"
    }
    
    private let client: HTTPNetworkClient
    private let tokenGenerator: BasicAuthTokenGenerator
    
    init(client: HTTPNetworkClient, tokenGenerator: BasicAuthTokenGenerator = BasicAuthTokenGenerator()) {
        self.client = client
        self.tokenGenerator = tokenGenerator
        client.headerFields[Constant.userAgent] = Constant.userAgentValue
    }
    
    func request(
        _ method: HTTPMethod,
        path: String,
        successCallback: @escaping (Data?) -> Void,
        failureCallback: ((Error?) -> Void)?
    ) {
        client.request(method, path: path) { data, response, error in
            guard let unwrappedResponse = response else {
                failureCallback?(InvalidResponse())
                return
            }
            switch unwrappedResponse.statusCode {
            case 200..<300:
                successCallback(data)
            case 401:
                failureCallback?(Unauthorized())
            case 400..., 500...:
                if let data = data {
                    failureCallback?(GitHubAPIError(
                        statusCode: unwrappedResponse.statusCode,
                        response: ModelDecoder<GitHubAPIError.Response>().model(from: data)
                    ))
                } else {
                    failureCallback?(GitHubAPIError(statusCode: unwrappedResponse.statusCode, response: nil))
                }
            default:
                failureCallback?(error)
            }
        }
    }
    
    func setBasicAuthToken(username: String, password: String) throws {
        client.headerFields[Constant.authorization]
            = "Basic \(try tokenGenerator.token(from: username, password: password))"
    }
}
