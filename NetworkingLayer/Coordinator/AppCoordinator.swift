//
//  AppCoordinator.swift
//  NetworkingLayer
//
//  Created by Abiú Ramírez Roldán on 27/02/25.
//

import UIKit

protocol AppCoordinatorProtocol {
    func showHomeCoordinator()
    func showPokemonDetailCoordinator(_ pokemonData: PokemonInfo)
}

final class AppCoordinator: Coordinator, AppCoordinatorProtocol {
    private let window: UIWindow?
    private let navigation: UINavigationController
    private var childCoordinators = [Coordinator]()

    init(window: UIWindow?) {
        self.window = window
        navigation = UINavigationController()
    }

    func start() {
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
        showHomeCoordinator()
    }

    func showHomeCoordinator() {
        let homeCoordinator = HomeCoordinator(navigation: navigation,
                                              appCoordinator: self)
        childCoordinators.append(homeCoordinator)
        homeCoordinator.start()
    }

    func showPokemonDetailCoordinator(_ pokemonData: PokemonInfo) {
        let detailsCoordinator = DetailsCoordinator(
            navigation: navigation,
            pokemonData
        )
        childCoordinators.append(detailsCoordinator)
        detailsCoordinator.start()
    }
}
