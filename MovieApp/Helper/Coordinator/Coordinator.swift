//
//  Coordinator.swift
//  MovieApp
//
//  Created by FEKRANE on 16/1/2024.
//

import SwiftUI

protocol Coordinator : AnyObject, ObservableObject {
    var router: Router { get }
    func start()
    func show(_ route: some BaseRoute, animated: Bool)
}

extension Coordinator {
    func show(_ route: some BaseRoute, animated: Bool = true) {
        show(route, animated: animated)
    }
}
