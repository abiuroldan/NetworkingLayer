//
//  NetworkManagerAPI.swift
//  NetworkingLayer
//
//  Created by Abiú Ramírez Roldán on 02/03/25.
//

public protocol NetworkManagerAPI {
    func fullPokemonList(request: APIRequestType, _ completion: @escaping (Result<PokemonList, NetworkError>) -> ()) async
}
