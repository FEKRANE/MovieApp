//
//  MoviesSectionConfigurator.swift
//  MovieApp
//
//  Created by FEKRANE on 10/1/2024.
//

import SwiftUI

extension MoviesSection {
    func configureView() -> some View {
        var view = self
        let interactor = MovieListInteractor()
        let presenter = MovieListPresenter()
        view.interactor = interactor
        interactor.presenter = presenter
        presenter.view = view
        
        return view
    }
}
