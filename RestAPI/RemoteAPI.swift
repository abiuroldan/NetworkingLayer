//
//  RemoteAPI.swift
//  NetworkingLayer
//
//  Created by Abiú Ramírez Roldán on 24/02/25.
//

import Foundation

public protocol PokemonListRemote {
    func fullPokemonList(request: APIRouter, _ completion: @escaping (PokemonList?) -> Void) async
    func pokemonBy(request: APIRouter, _ completion: @escaping (PokemonData?) -> ()) async
}

public struct PokemonListRemoteAPI: PokemonListRemote {
    public init() {}

    public func fullPokemonList(request: APIRouter, _ completion: @escaping (PokemonList?) -> Void) async {
        await NetworkManager.shared.makeCall(request: request, decodeTo: PokemonList.self) { response in
            switch response {
            case .success(let data):
                completion(data)
            case .failure(let error):
                print("request fullList error \(error)")
                completion(nil)
            }
        }
    }

    public func pokemonBy(request: APIRouter, _ completion: @escaping (PokemonData?) -> ()) async {
        await NetworkManager.shared.makeCall(request: request, decodeTo: PokemonData.self) { response in
            switch response {
            case .success(let data):
                completion(data)
            case .failure(let error):
                print("request pokemonBy error \(error)")
                completion(nil)
            }
        }
    }
}
