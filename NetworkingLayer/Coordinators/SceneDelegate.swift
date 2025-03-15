//
//  SceneDelegate.swift
//  NetworkingLayer
//
//  Created by Abiu Ramirez on 21/02/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let appCoordinator = AppCoordinator(window: window)
        appCoordinator.start()

        if let userActivity = connectionOptions.userActivities.first,
               isHasUniversalLink(userActivity) {
            self.scene(scene, continue: userActivity)
        } else {
            self.scene(scene, openURLContexts: connectionOptions.urlContexts)
        }
    }

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {}

    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {}

    private func isHasUniversalLink(_ userActivity: NSUserActivity) -> Bool {
        userActivity.activityType == NSUserActivityTypeBrowsingWeb
    }
}
