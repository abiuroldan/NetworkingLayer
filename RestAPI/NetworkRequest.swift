//
//  NetworkRequest.swift
//  NetworkingLayer
//
//  Created by Abiú Ramírez Roldán on 23/02/25.
//

import Foundation

protocol NetworkRequest {
    var url: URL? { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var parameters: Encodable? { get }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum ContentType: String {
    case json = "application/json"
    case xml = "applicatrion/xml"
    case formUrlEncoded = "application/x-www-form-urlencoded"
}

extension NetworkRequest {
    func urlRequest() throws -> URLRequest {
        guard let url else {
            throw NetworkError.badURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers

        if let parameters = parameters {
            if method == .get {
                var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
                let parameterData = try JSONEncoder().encode(parameters)
                let parameterDictionary = try JSONSerialization.jsonObject(with: parameterData, options: []) as? [String: Any]
                urlComponents?.queryItems = parameterDictionary?.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
                request.url = urlComponents?.url
                request.httpMethod = method.rawValue
            } else {
                do {
                    let jsonData = try JSONEncoder().encode(parameters)
                    request.httpBody = jsonData
                } catch {
                    throw NetworkError.encodingFailed(error)
                }
            }
        }
        return request
    }
}
