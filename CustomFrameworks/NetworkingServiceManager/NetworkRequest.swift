//
//  NetworkRequest.swift
//  NetworkingLayer
//
//  Created by Abiú Ramírez Roldán on 09/03/25.
//

public protocol NetworkRequest {
    var url: URL? { get }
    var method: HttpMethod { get }
    var headers: [String: String]? { get }
    var parameters: Encodable? { get }
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
            switch method {
            case .get:
                request.url = try appedQueryParameters(to: url, parameters: parameters)
            default:
                request.httpBody = try parameters.encodeBody()
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        }

        return request
    }
}

// Converts a dictionary into query parameters and appends them to the URL
func appedQueryParameters(to url: URL, parameters: Encodable) throws -> URL {
    guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
        throw NetworkError.badURL
    }

    let dictionary = try parameters.toDictionary()
    urlComponents.queryItems = dictionary.map { URLQueryItem(name: $0.key, value: "\($0.value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))}

    guard let finalURL = urlComponents.url else {
        throw NetworkError.badURL
    }

    return finalURL
}
