//
//  APICallRequest.swift
//  NetworkingLayer
//
//  Created by Abiú Ramírez Roldán on 23/02/25.
//

import Foundation

public protocol PokemonListRemote {
    func fullPokemonList<T: Decodable>(type: T.Type, request: APIRouter, _ completion: @escaping (T?) -> Void) async
}

public struct PokemonListRemoteAPI: PokemonListRemote {
    public init() {}

    public func fullPokemonList<T: Decodable>(type: T.Type, request: APIRouter, _ completion: @escaping (T?) -> Void) async {
        await NetworkManager.shared.makeCall(request: request, decodeTo: T.self) { response in
            completion(response)
        }
    }
}

protocol APICallRequestProtocol {
//    func pokemonByName<T: Decodable>(name: String) -> T
//    func pokemonById<T: Decodable>(id: Int) -> T
}
