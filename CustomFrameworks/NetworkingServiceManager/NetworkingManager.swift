//
//  NetworkingManager.swift
//  NetworkingLayer
//
//  Created by Abiú Ramírez Roldán on 01/03/25.
//

import Foundation
import Combine

final class NetworkManager: NetworkingManagerService {
    private let session: URLSession

    init() {
        let memoryCapacity = 50 * 1024 * 1024 // 50MB memory cache
        let diskCapacity = 200 * 1024 * 1024 // 200MB disk cache
        let cache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity)
        URLCache.shared = cache // Globally

        let config = URLSessionConfiguration.ephemeral
        config.urlCache = URLCache.shared
        config.requestCachePolicy = .returnCacheDataElseLoad
        let session = URLSession(configuration: config)
        self.session = session
    }

    private func processResponse(_ response: URLResponse?) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.noResponse
        }

        if(200...299).contains(httpResponse.statusCode) {
            return
        }

        throw NetworkError.from(statusCode: httpResponse.statusCode)
    }
}

// MARK: - Combine
extension NetworkManager {
    func fetchData<T: Decodable>(_ request: NetworkRequest, type: T.Type) throws -> AnyPublisher<T, NetworkError> {
        let urlRequest = try request.urlRequest()
        let decoder = JSONDecoder(isSnakeCaseConverting: true)
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        // Check if a cached response exists
        if let cachedResponse = URLCache.shared.cachedResponse(for: urlRequest) {
            return Just(cachedResponse.data)
                .decode(type: T.self, decoder: decoder)
                .mapError(NetworkErrorMapper.map)
                .eraseToAnyPublisher()
        }

        return session
            .dataTaskPublisher(for: urlRequest)
            .tryMap { [weak self] element -> Data in
                guard let self else { throw NetworkError.dataNotFound }

                // Handle HTTP response validation errors
                try self.processResponse(element.response)

                // Ensure data is present
                guard !element.data.isEmpty else {
                    throw NetworkError.dataNotFound
                }

                // Store response in cache
                let cachedResponse = CachedURLResponse(response: element.response, data: element.data)
                URLCache.shared.storeCachedResponse(cachedResponse, for: urlRequest)

                return element.data
            }
            .decode(type: T.self, decoder: decoder)
            .mapError(NetworkErrorMapper.map)
            .timeout(.seconds(10), scheduler: DispatchQueue.global(), customError: { NetworkError.requestTimeOut })
            .retry(3)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
