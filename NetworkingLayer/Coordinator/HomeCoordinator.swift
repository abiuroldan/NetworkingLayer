//
//  HomeCoordinator.swift
//  NetworkingLayer
//
//  Created by Abiú Ramírez Roldán on 27/02/25.
//

import UIKit

final class HomeCoordinator: Coordinator {
    private let navigation: UINavigationController
    private let appCoordinator: AppCoordinatorProtocol

    init(navigation: UINavigationController,
         appCoordinator: AppCoordinatorProtocol) {
        self.appCoordinator = appCoordinator
        self.navigation = navigation
    }

    func start() {
        let viewModel = HomeViewModel(appCoordinator: appCoordinator)
        let homeController = HomeViewController(viewModel: viewModel)
        navigation.pushViewController(homeController, animated: false)
    }
}
