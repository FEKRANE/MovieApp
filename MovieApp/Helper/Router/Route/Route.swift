//
//  BaseRoute.swift
//  MovieApp
//
//  Created by FEKRANE on 17/1/2024.
//

import SwiftUI

protocol BaseRoute {

    associatedtype V: View

    @ViewBuilder
    func view() -> V
}

 enum Route: BaseRoute {
    
    case movieList(category: MovieCategory)
    case movieDetail
    
    @ViewBuilder
    public func view() -> some View {
        switch self {
        case .movieList(category: let category):
            MovieListScreen(movieCategory: category).configureView()
        case .movieDetail:
            MovieDetailScreen()
        }
    }
}
