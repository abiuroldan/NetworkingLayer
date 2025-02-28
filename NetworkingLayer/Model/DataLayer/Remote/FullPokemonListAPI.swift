//
//  FullPokemonListAPI.swift
//  NetworkingLayer
//
//  Created by Abiú Ramírez Roldán on 26/02/25.
//

import Foundation
import RestAPI

struct FullPokemonListAPI {
    var count: Int

    init(data: PokemonList) {
        self.count = data.count
    }
}
