//
//  SceneDelegate.swift
//  ShoppingCart
//

import UIKit
import Combine

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var coordinator: MainCoordinator!
    var subscriber: AnyCancellable?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        
        let rootNavigationController = UINavigationController()
        self.coordinator = MainCoordinator(rootNavigationController: rootNavigationController)
        window?.rootViewController = rootNavigationController
        subscriber = coordinator?.start().sink(receiveValue: {})
    }
}
