//
//  MovieListConfigurator.swift
//  MovieApp
//
//  Created by FEKRANE on 1/1/2024.
//

import SwiftUI

extension MovieListScreen {
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
