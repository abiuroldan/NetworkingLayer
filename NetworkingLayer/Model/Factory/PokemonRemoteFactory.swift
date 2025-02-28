//
//  PokemonRemoteFactory.swift
//  NetworkingLayer
//
//  Created by Abiú Ramírez Roldán on 26/02/25.
//

protocol PokemonRemoteFactory {
    func fullList(_ completion: @escaping (FullPokemonListAPI) -> ())
    func searchBy(name: String, _ completion: @escaping (PokemonInfo) -> ())
}
