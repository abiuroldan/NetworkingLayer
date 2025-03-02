//
//  NetworkManagerAPIService.swift
//  NetworkingLayer
//
//  Created by Abiú Ramírez Roldán on 02/03/25.
//

public final class NetworkManagerAPIService: NetworkManagerAPI {
    private let network = NetworkManager()
    public init() {}

    public func fullPokemonList(request: APIRequestType, _ completion: @escaping (Result<PokemonList, NetworkError>) -> ()) async {
        await network.makeCall(request: request, PokemonList.self) { result in
            completion(result)
        }
    }
}
