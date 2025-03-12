//
//  RemoteService.swift
//  NetworkingLayer
//
//  Created by Abiú Ramírez Roldán on 27/02/25.
//

import Combine
import NetworkingServiceManager

final class RemoteService: RemoteServiceAPI {
    let remoteAPI: NetworkManagerAPI
    
    init(remoteAPI: NetworkManagerAPI = NetworkManagerAPIService()) {
        self.remoteAPI = remoteAPI
    }

    func fetchPokemonList() async throws -> AnyPublisher<FullLIstPokemon, NetworkError>  {
        try await remoteAPI.fetchPokemonList(request: .full)
            .map { FullLIstPokemon(data: $0) }
            .eraseToAnyPublisher()
    }
}
