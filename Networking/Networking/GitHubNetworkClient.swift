//
//  GitHubNetworkClient.swift
//  redux-swift
//
//  Created by Bartłomiej Nowak on 06.05.2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import Foundation

public struct APIErrorModel {
    public struct Response: Codable {
        public let message: String
    }
    
    public let statusCode: Int
    public let response: Response?
}

public enum GitHubNetworkClientError {
    case unauthorized
    case invalidResponse
    case apiError(APIErrorModel?)
    case other
}

public protocol GitHubNetworkClientInterface {
    func request(
        _ method: HTTPMethod,
        path: String,
        success: @escaping (Data?) -> Void,
        failure: @escaping (GitHubNetworkClientError) -> Void
    )
    func setBasicAuthToken(username: String, password: String) throws
}

public final class GitHubNetworkClient: GitHubNetworkClientInterface {
    
    private struct Constant {
        static let userAgent = "User-Agent"
        static let authorization = "Authorization"
        static let userAgentValue = "bartlomiejn/test-pyramid"
    }
    
    private let httpClient: HTTPNetworkClient
    private let tokenGenerator: BasicAuthTokenGenerator
    
    public init(client: HTTPNetworkClient, tokenGenerator: BasicAuthTokenGenerator = BasicAuthTokenGenerator()) {
        self.httpClient = client
        self.tokenGenerator = tokenGenerator
        client.headerFields[Constant.userAgent] = Constant.userAgentValue
    }
    
    public func request(
        _ method: HTTPMethod,
        path: String,
        success: @escaping (Data?) -> Void,
        failure: @escaping (GitHubNetworkClientError) -> Void
    ) {
        httpClient.request(method, path: path) { [weak self] data, response, error in
            guard let unwrappedResponse = response else {
                failure(.invalidResponse)
                return
            }
            switch unwrappedResponse.statusCode {
            case 200..<300:
                success(data)
            case 401:
                failure(.unauthorized)
            case 400..., 500...:
                self?.handleErrorStatus(data: data, statusCode: unwrappedResponse.statusCode, failure: failure)
            default:
                failure(.other)
            }
        }
    }
    
    public func setBasicAuthToken(username: String, password: String) throws {
        httpClient.headerFields[Constant.authorization]
            = "Basic \(try tokenGenerator.token(from: username, password: password))"
    }
    
    private func handleErrorStatus(
        data: Data?,
        statusCode: Int,
        failure: @escaping (GitHubNetworkClientError) -> Void
    ) {
        if let data = data {
            failure(.apiError(APIErrorModel(
                statusCode: statusCode,
                response: ModelDecoder<APIErrorModel.Response>().model(from: data)
            )))
        } else {
            failure(.apiError(APIErrorModel(statusCode: statusCode, response: nil)))
        }
    }
}
