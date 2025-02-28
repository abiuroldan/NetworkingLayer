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

    func testEmptyWindow() throws {
        let window = windowSceneMock?.windows.first
        let appCoordinator = AppCoordinator(window: window)
        appCoordinator.start()

        XCTAssertNotNil(window)
        XCTAssert(appCoordinator.testValues.viewControllers.isNotEmpty)
        XCTAssert(appCoordinator.testValues.viewControllers.count > 0)
    }
}
