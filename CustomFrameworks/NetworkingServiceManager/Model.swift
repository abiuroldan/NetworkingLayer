//
//  Model.swift
//  NetworkingLayer
//
//  Created by Abiú Ramírez Roldán on 02/03/25.
//

public struct PokemonList: Decodable {
    public let count: Int
    public let next: String
    public let previous: String?
    public let results: [PokemonItem]
}

public struct PokemonItem: Decodable {
    public let name: String
    public let url: String
}
