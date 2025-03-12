//
//  HomeViewModelProtocol.swift
//  NetworkingLayer
//
//  Created by Abiú Ramírez Roldán on 28/02/25.
//

import Combine
import NetworkingServiceManager

protocol HomeViewModelProtocol: ViewModel {
    func fetchPokemonList()
    var pokemonListPublisher: Published<FullLIstPokemon?>.Publisher { get }
}
