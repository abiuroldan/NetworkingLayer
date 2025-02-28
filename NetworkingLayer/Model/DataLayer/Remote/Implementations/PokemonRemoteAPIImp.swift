//
//  PokemonRemoteAPIImp.swift
//  NetworkingLayer
//
//  Created by Abiú Ramírez Roldán on 26/02/25.
//

import RestAPI

struct PokemonRemoteAPIImp: PokemonRemoteFactory {
    @Injected(\.networkProvider) private var networkProvider: PokemonListRemote

    func fullList(_ completion: @escaping (FullPokemonListAPI) -> ()) {
        Task {
            await networkProvider.fullPokemonList(request: .fullLIst) { response in
                guard let response else {
                    print("no response")
                    return
                }
                let value = FullPokemonListAPI(data: response)
                completion(value)
            }
        }
    }

    func searchBy(name: String, _ completion: @escaping (PokemonInfo) -> ()) {
        Task {
            await networkProvider.pokemonBy(request: .byName(name)) { response in
                guard let response else {
                    print("no response")
                    return
                }
                let value = PokemonInfo(data: response)
                completion(value)
            }
        }
    }
}
