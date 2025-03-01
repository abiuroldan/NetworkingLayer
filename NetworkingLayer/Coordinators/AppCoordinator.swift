//
//  AppCoordinator.swift
//  NetworkingLayer
//
//  Created by Abiú Ramírez Roldán on 27/02/25.
//

import UIKit

final class AppCoordinator: Coordinator {
    private let navigationController = UINavigationController()
    private var window: UIWindow?

    init(window: UIWindow?) {
        guard let window else {
            fatalError("Window can't be empty")
        }
        self.window = window
        window.makeKeyAndVisible()
        window.rootViewController = navigationController
    }

    func start() {
        let homeController = ViewController()
        homeController.view.backgroundColor = .background
        navigationController.pushViewController(homeController, animated: false)
    }
}

#if DEBUG
extension AppCoordinator {
    var testValues: TestValues {
        .init(target: self)
    }
    
    struct TestValues {
        let target: AppCoordinator
        init(target: AppCoordinator) {
            self.target = target
        }
        
        var window: UIWindow? {
            target.window
        }
        
        var navigationController: UIViewController {
            target.navigationController
        }

        var viewControllers: [UIViewController] {
            target.navigationController.viewControllers
        }
    }
}
#endif
