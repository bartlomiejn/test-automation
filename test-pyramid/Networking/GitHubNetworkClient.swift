//
//  GitHubNetworkClient.swift
//  redux-swift
//
//  Created by Bartłomiej Nowak on 06.05.2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import Foundation

struct GitHubAPIErrorResponse {
    struct Response: Codable {
        let message: String
    }
    
    let statusCode: Int
    let response: Response?
}

enum GitHubNetworkClientError {
    case unauthorized
    case invalidResponse
    case apiError(GitHubAPIErrorResponse?)
    case other
}

protocol GitHubNetworkClientInterface {
    func request(
        _ method: HTTPMethod,
        path: String,
        successCallback: @escaping (Data?) -> Void,
        failureCallback: @escaping (GitHubNetworkClientError) -> Void
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
        failureCallback: @escaping (GitHubNetworkClientError) -> Void
    ) {
        client.request(method, path: path) { data, response, error in
            guard let unwrappedResponse = response else {
                failureCallback(.invalidResponse)
                return
            }
            switch unwrappedResponse.statusCode {
            case 200..<300:
                successCallback(data)
            case 401:
                failureCallback(.unauthorized)
            case 400..., 500...:
                if let data = data {
                    failureCallback(.apiError(GitHubAPIErrorResponse(
                        statusCode: unwrappedResponse.statusCode,
                        response: ModelDecoder<GitHubAPIErrorResponse.Response>().model(from: data)
                    )))
                } else {
                    failureCallback(.apiError(GitHubAPIErrorResponse(
                        statusCode: unwrappedResponse.statusCode,
                        response: nil
                    )))
                }
            default:
                failureCallback(.other)
            }
        }
    }
    
    func setBasicAuthToken(username: String, password: String) throws {
        client.headerFields[Constant.authorization]
            = "Basic \(try tokenGenerator.token(from: username, password: password))"
    }
}
