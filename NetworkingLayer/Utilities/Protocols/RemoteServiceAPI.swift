//
//  RemoteServiceAPI.swift
//  NetworkingLayer
//
//  Created by Abiú Ramírez Roldán on 02/03/25.
//

struct FullLIstPokemon {
    let previous: String?
    let result: [ItemPokemon]

    init(data: PokemonList) {
        previous = data.previous
        result = data.results.map { ItemPokemon(data: $0) }
    }
}

struct ItemPokemon {
    let name: String
    let url: String

    init(data: PokemonItem) {
        name = data.name
        url = data.url
    }
}

import NetworkingServiceManager

protocol RemoteServiceAPI {
    func fullPokemonList(_ completion: @escaping (Result<FullLIstPokemon, NetworkError>) -> ())
}
