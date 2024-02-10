//
//  NavigationRouter.swift
//  MovieApp
//
//  Created by FEKRANE on 16/1/2024.
//

import SwiftUI
 class NavigationRouter: NSObject {
    
    private let navigationController: UINavigationController
     var routerRootController: UIViewController {
         navigationController
     }
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
    }
}

// MARK: - Router
extension NavigationRouter: Router {
    
    func setRoot(_ vc: UIViewController) {
        navigationController.setViewControllers([vc], animated: true)
    }
    
    
    func redirect(to viewController: UIViewController, animated: Bool) {
        navigationController.pushViewController(
            viewController,
            animated: animated
        )
    }
    
    func pop(animated: Bool) {
        navigationController.popToRootViewController(
            animated: animated
        )
    }
}
