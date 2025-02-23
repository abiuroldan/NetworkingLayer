//
//  NetworkManager.swift
//  NetworkingLayer
//
//  Created by Abiú Ramírez Roldán on 22/02/25.
//

import Foundation

public class NetworkManager {
    public static let shared = NetworkManager()
    private let urlSession = URLSession(configuration: .ephemeral)
    private init() {}
    
    func makeCall<T: Decodable>(request: NetworkRequest, decodeTo type: T.Type, completion: @escaping (T?) -> Void) async {
        if #available(iOS 15.0, *) {
            do {
                let data: T = try await perform(request, decodeTo: T.self)
                completion(data)
            } catch {
                print("Failed to fech data \(error)")
                completion(nil)
            }
        } else {
            perform(request, decodeTo: T.self) { result in
                switch result {
                case .success(let data):
                    completion(data)
                case .failure(let error):
                    print("Failed to fech data \(error)")
                    completion(nil)
                }
            }
        }
    }

    func perform<T: Decodable>(_ request: NetworkRequest, decodeTo type: T.Type) async throws -> T {
        if #available(iOS 15.0, *) {
            /// Use URLSession to fetch the data asynchronously.
            let urlRequest = try request.urlRequest()
            let (data, response) = try await urlSession.data(for: urlRequest)
            try processResponse(response: response)
            return try decodeData(data: data, type: T.self)
        } else {
            return try await withCheckedThrowingContinuation { continuation in
                perform(request, decodeTo: T.self) { result in
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

    private func decodeData<T: Decodable>(data: Data, type: T.Type) throws -> T {
        do {
            let decodedObject = try JSONDecoder().decode(T.self, from: data)
            return decodedObject
        } catch let decodingError {
            throw NetworkError.decodingFailed(decodingError)
        }
    }

    private func processResponse(response: URLResponse?) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }

        switch httpResponse.statusCode {
        case 200...299:
            return
        case 404:
            throw NetworkError.notFound
        case 500:
            throw NetworkError.internalServerError
        default:
            throw NetworkError.unknownError(statusCode: httpResponse.statusCode)
        }
    }
}

extension NetworkManager {
    func perform<T: Decodable>(_ request: NetworkRequest, decodeTo type: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) {
        do {
            let urlRequest = try request.urlRequest()
            urlSession.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    completion(.failure(.requestFailed(error)))
                    return
                }

                guard let data = data else {
                    completion(.failure(.dataNotFound))
                    return
                }

                do {
                    try self.processResponse(response: response)
                    let decodedObject = try self.decodeData(data: data, type: T.self)
                    completion(.success(decodedObject))
                } catch {
                    completion(.failure(error as? NetworkError ?? .invalidResponse))
                }
            }.resume()
        } catch {
            completion(.failure(error as? NetworkError ?? .invalidResponse))
        }
    }
}
