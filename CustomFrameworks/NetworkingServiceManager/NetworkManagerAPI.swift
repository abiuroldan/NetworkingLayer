//
//  NetworkManagerAPI.swift
//  NetworkingLayer
//
//  Created by Abiú Ramírez Roldán on 02/03/25.
//

import Combine

public protocol NetworkManagerAPI {
    func fetchPokemonList<T: Decodable>(request: APIRequestType) async throws -> AnyPublisher<T, NetworkError>
}
