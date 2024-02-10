//
//  SceneDelegate.swift
//  MovieApp
//
//  Created by FEKRANE on 16/1/2024.
//

import SwiftUI

class SceneDelegate: NSObject, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var coordinator: MainCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let navigationController = UINavigationController()
        navigationController.setNavigationBarHidden(true, animated: false)
        window = UIWindow(windowScene: windowScene)
        let router = NavigationRouter(navigationController: navigationController)
        coordinator = MainCoordinator(router: router)
        coordinator?.start()
        
        self.window?.rootViewController = coordinator?.router.routerRootController
        self.window?.makeKeyAndVisible()
    }
}
