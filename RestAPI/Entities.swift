//
//  Entities.swift
//  NetworkingLayer
//
//  Created by Abiú Ramírez Roldán on 22/02/25.
//

public struct PokemonList: Decodable {
    let count: Int
    let next: String
    let previous: String?
    let results: [Pokemon]
}

public struct Pokemon: Decodable {
    let name: String
    let url: String
}
