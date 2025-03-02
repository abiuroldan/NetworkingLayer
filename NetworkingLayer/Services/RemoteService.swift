//
//  RemoteService.swift
//  NetworkingLayer
//
//  Created by Abiú Ramírez Roldán on 27/02/25.
//

import NetworkingServiceManager


final class RemoteService: RemoteServiceAPI {
    let remoteAPI = NetworkManagerAPIService()
    
    func fullPokemonList(_ completion: @escaping (Result<FullLIstPokemon, NetworkError>) -> ()) {
        Task {
            await remoteAPI.fullPokemonList(request: .full) { result in
                switch result {
                case .success(let data):
                    let pokemonList = FullLIstPokemon(data: data)
                    completion(.success(pokemonList))
                case .failure(let error):
                    print(error)
                    completion(.failure(error))
                }
            }
        }
    }
}
