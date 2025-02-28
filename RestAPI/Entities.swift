//
//  Entities.swift
//  NetworkingLayer
//
//  Created by Abiú Ramírez Roldán on 22/02/25.
//

public struct PokemonList: Decodable {
    public let count: Int
    public let next: String
    public let previous: String?
    public let results: [Pokemon]
}

public struct Pokemon: Decodable {
    let name: String
    let url: String
}

// MARK: - PokemonData
public struct PokemonData: Decodable {
    let abilities: [Ability]?
    let baseExperience: Int?
    public let height: Int
    public let id: Int
    public let name: String
    public let sprites: Sprites
    public let weight: Int
}

// MARK: - Ability
struct Ability: Decodable {
    let ability: Species
    let isHidden: Bool
    let slot: Int
}

// MARK: - Species
struct Species: Decodable {
    let name: String
    let url: String
}

// MARK: - Sprites
public struct Sprites: Decodable {
    public let frontDefault: String?
}

