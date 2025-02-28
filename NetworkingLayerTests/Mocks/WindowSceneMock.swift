//
//  WindowSceneMock.swift
//  NetworkingLayer
//
//  Created by Abiú Ramírez Roldán on 27/02/25.
//

import UIKit
@testable import NetworkingLayer

protocol WindowSceneProtocol {
    var windows: [UIWindow] { get }
}

extension UIWindowScene: WindowSceneProtocol {}

final class WindowSceneMock: WindowSceneProtocol {
    var windows: [UIWindow] = [UIWindow()]
}
