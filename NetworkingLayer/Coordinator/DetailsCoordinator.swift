//
//  DetailsCoordinator.swift
//  NetworkingLayer
//
//  Created by Abiú Ramírez Roldán on 27/02/25.
//

import UIKit

final class DetailsCoordinator: Coordinator {
    private let navigation: UINavigationController
    private let pokemon: PokemonInfo

    init(navigation: UINavigationController,
         _ pokemonData: PokemonInfo) {
        self.navigation = navigation
        self.pokemon = pokemonData
    }

    func start() {
        let viewModel = PokemonDetailsViewModel(
            pokemon
        )
        let detailsController = PokemonDetailViewController(
            viewModel: viewModel
        )
        navigation.pushViewController(
            detailsController,
            animated: true
        )
    }
}
