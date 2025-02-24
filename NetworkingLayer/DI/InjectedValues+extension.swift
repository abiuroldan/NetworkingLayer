//
//  InjectedValues+extension.swift
//  NetworkingLayer
//
//  Created by Abiú Ramírez Roldán on 23/02/25.
//

import RestAPI

extension InjectedValues {
    var networkProvider: PokemonListRemote {
        get { Self[NetworkProviderKey.self] }
        set { Self[NetworkProviderKey.self] = newValue }
    }
}
