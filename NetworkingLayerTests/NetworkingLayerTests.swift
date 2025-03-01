//
//  NetworkingLayerTests.swift
//  NetworkingLayerTests
//
//  Created by Abiu Ramirez on 21/02/25.
//

import XCTest
@testable import NetworkingLayer

final class NetworkingLayerTests: XCTestCase {
    var windowSceneMock: WindowSceneMock?

    override func setUp() {
        windowSceneMock = WindowSceneMock()
    }

    override func tearDown() {
        windowSceneMock = nil
    }

    func testNoStartingAppCoordinator() throws {
        let window = windowSceneMock?.windows.first
        let appCoordinator = AppCoordinator(window: window)

        XCTAssertNotNil(appCoordinator.testValues.window)
        XCTAssertTrue(appCoordinator.testValues.viewControllers.isEmpty)
        XCTAssertTrue(appCoordinator.testValues.childCoordinators.isEmpty)
    }

    func testStartingAppCoordinator() {
        let window = windowSceneMock?.windows.first
        let appCoordinator = AppCoordinator(window: window)
        appCoordinator.start()

        XCTAssertNotNil(appCoordinator.testValues.window)
        XCTAssert(appCoordinator.testValues.viewControllers.isNotEmpty)
        XCTAssert(appCoordinator.testValues.childCoordinators.count == 1)
    }

    func testNotStartingHomeCoordinator() {
        let appCoordinatorMock = AppCoordinatorMock()
        let homeCoordinator = HomeCoordinator(navigationController: appCoordinatorMock.navController())

        XCTAssertTrue(homeCoordinator.testValues.childControllers.isEmpty)
    }

    func testStartingHomeCoordinator() {
        let appCoordinatorMock = AppCoordinatorMock()
        let homeCoordinator = HomeCoordinator(navigationController: appCoordinatorMock.navController())
        homeCoordinator.start()

        XCTAssertTrue(homeCoordinator.testValues.childControllers.isNotEmpty)
    }
}
