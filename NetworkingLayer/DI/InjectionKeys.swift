//
//  InjectionKeys.swift
//  NetworkingLayer
//
//  Created by Abiú Ramírez Roldán on 23/02/25.
//

import RestAPI

struct NetworkProviderKey: InjectionKey {
    static var currentValue: PokemonListRemote = PokemonListRemoteAPI()
}
