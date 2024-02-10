//
//  MainCoordinator.swift
//  MovieApp
//
//  Created by FEKRANE on 16/1/2024.
//

import SwiftUI

class MainCoordinator: Coordinator {
    
    var router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    func start() {
        let rootVC =  UIHostingController(
            rootView: ContentView().environmentObject(self)
        )
        router.setRoot(rootVC)
    }
    
    func show(_ route: some BaseRoute, animated: Bool) {
        let view = route.view().environmentObject(self)
        push(view: view, animated: animated)
    }
}

//MARK: - Navigation
extension MainCoordinator {
    private func push(view: some View, animated: Bool) {
        let viewController =  UIHostingController(rootView: view)
        router.redirect(to: viewController, animated: animated)
    }
    
    private func navigateBack(animated: Bool) {
        router.pop(animated: true)
    }
}
