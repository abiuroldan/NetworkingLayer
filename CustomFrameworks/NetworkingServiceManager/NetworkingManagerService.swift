//
//  NetworkingManagerService.swift
//  NetworkingLayer
//
//  Created by Abiú Ramírez Roldán on 09/03/25.
//

import Combine

public protocol NetworkingManagerService {
    func fetchData<T: Decodable>(_ request: NetworkRequest, type: T.Type) throws -> AnyPublisher<T, NetworkError>
}
