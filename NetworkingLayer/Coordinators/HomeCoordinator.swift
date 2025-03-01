//
//  HomeCoordinator.swift
//  NetworkingLayer
//
//  Created by Abiú Ramírez Roldán on 28/02/25.
//

import UIKit

final class HomeCoordinator: Coordinator {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewModel = HomeViewModel()
        let homeViewController = HomeViewController(viewModel: viewModel)
        navigationController.pushViewController(homeViewController, animated: false)
    }
}

#if DEBUG
extension HomeCoordinator {
    var testValues: TestValues {
        .init(target: self)
    }
    
    struct TestValues {
        let target: HomeCoordinator
        init(target: HomeCoordinator) {
            self.target = target
        }

        var childControllers: [UIViewController] {
            target.navigationController.viewControllers
        }
    }
}
#endif
