//
//  NetworkManagerAPIService.swift
//  NetworkingLayer
//
//  Created by Abiú Ramírez Roldán on 02/03/25.
//

import Combine

public final class NetworkManagerAPIService: NetworkManagerAPI {
    private var network: NetworkingManagerService
    public init() {
        network = NetworkManager()
    }

    convenience init(network: NetworkingManagerService) {
        self.init()
        self.network = network
    }
    public func fetchPokemonList<T: Decodable>(request: APIRequestType) async throws -> AnyPublisher<T, NetworkError> {
        try network.fetchData(request, type: T.self)
    }
}
