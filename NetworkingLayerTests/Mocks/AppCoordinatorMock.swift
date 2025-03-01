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
    private let windowSceneMock = WindowSceneMock()
    private var window: UIWindow?

    init() {
        self.window = windowSceneMock.windows.first
        window?.makeKeyAndVisible()
        window?.rootViewController = navigationController
    }

    func start() {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .background
        navigationController.pushViewController(viewController, animated: false)
    }

    func navController() -> UINavigationController {
        navigationController
    }
}
