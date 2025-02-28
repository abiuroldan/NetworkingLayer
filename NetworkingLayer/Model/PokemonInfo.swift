//
//  PokemonInfo.swift
//  NetworkingLayer
//
//  Created by Abiú Ramírez Roldán on 26/02/25.
//

import Foundation
import RestAPI

struct PokemonInfo {
    var name: String
    let height: Int
    let weight: Int
    let id: Int
    let image: String?

    init(data: PokemonData) {
        name = data.name
        height = data.height
        weight = data.weight
        id = data.id
        image = data.sprites.frontDefault
    }
}
