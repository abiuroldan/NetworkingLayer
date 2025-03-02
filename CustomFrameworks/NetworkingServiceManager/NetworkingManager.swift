//
//  NetworkingManager.swift
//  NetworkingLayer
//
//  Created by Abiú Ramírez Roldán on 01/03/25.
//

import Foundation

class NetworkManager {
    let session = URLSession(configuration: .ephemeral)
    func makeCall<T: Decodable>(request: NetworkRequest, _ type: T.Type, _ completion: @escaping (Result<T, NetworkError>) -> ()) async {
        if #available(iOS 15.0, *) {
            do {
                let data: T = try await perform(request, type: T.self)
                completion(.success(data))
            } catch {
                completion(.failure(error as? NetworkError ?? .invalidResponse))
            }
        } else {
            perform(request, type: T.self) { result in
                completion(result)
            }
        }
    }

    func perform<T: Decodable>(_ request: NetworkRequest, type: T.Type) async throws -> T {
        if #available(iOS 15.0, *) {
            /// Use URLSession to fetch the data asynchronously
            let urlRequest = try request.urlRequest()
            let (data, response) = try await session.data(for: urlRequest)
            try processResponse(response)
            return try decode(T.self, data: data)
        } else {
            return try await withCheckedThrowingContinuation { continuation in
                perform(request, type: T.self) { result in
                    switch result {
                    case .success(let data):
                        continuation.resume(returning: data)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
            }
        }
    }

    func decode<T: Decodable>(_ type: T.Type, data: Data) throws -> T {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let dataDecoded = try decoder.decode(T.self, from: data)
            return dataDecoded
        } catch let decodingError {
            throw NetworkError.decodingFailed(decodingError)
        }
    }

    private func processResponse(_ response: URLResponse?) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        switch httpResponse.statusCode {
        case 200...299:
            return
        case 400:
            throw NetworkError.badRequest
        case 401:
            throw NetworkError.unauthorized
        case 403:
            throw NetworkError.forbidden
        case 404:
            throw NetworkError.notFound
        case 408:
            throw NetworkError.requestTimeOut
        case 500:
            throw NetworkError.serverError
        case 502:
            throw NetworkError.badGatway
        default:
            throw NetworkError.unknownError(statusCode: httpResponse.statusCode)
        }
    }
}

extension NetworkManager {
    func perform<T: Decodable>(_ request: NetworkRequest, type: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void ) {
        do {
            let urlRequest = try request.urlRequest()
            session.dataTask(with: urlRequest) { [weak self] data, response, error in
                guard let self else {
                    completion(.failure(.dataNotFound))
                    return
                }
                if let error = error {
                    completion(.failure(.requestFailed(error)))
                    return
                }

                guard let data else {
                    completion(.failure(.dataNotFound))
                    return
                }

                do {
                    try processResponse(response)
                    let decodedObject = try decode(T.self, data: data)
                    completion(.success(decodedObject))
                } catch {
                    completion(.failure(error as? NetworkError ?? .invalidResponse))
                }
            }
        } catch {
            completion(.failure(error as? NetworkError ?? .invalidResponse))
        }
    }
}

protocol NetworkRequest {
    var url: URL? { get }
    var method: HttpMethod { get }
    var headers: [String: String]? { get }
    var parameters: Encodable? { get }
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
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
                urlComponents?.queryItems = parameterDictionary?.map { URLQueryItem(name: $0.key, value: "\($0.value)")}
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
