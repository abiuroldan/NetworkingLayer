//
//  AppCoordinatorMock.swift
//  NetworkingLayer
//
//  Created by Abiú Ramírez Roldán on 27/02/25.
//

@testable import NetworkingLayer
import UIKit

final class AppCoordinatorMock: Coordinator {
    private let navigationController = UINavigationController()
    private var window: UIWindow?

    init(window: UIWindow?) {
        self.window = window
        window?.makeKeyAndVisible()
        window?.rootViewController = navigationController
    }

    func start() {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .background
        navigationController.pushViewController(viewController, animated: false)
    }
}
