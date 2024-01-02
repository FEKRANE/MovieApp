//
//  HomeConfigurator.swift
//  MovieApp
//
//  Created by FEKRANE on 31/12/2023.
//

import Foundation

import SwiftUI

extension HomeScreen {
  func configureView() -> some View {
    var view = self
    let interactor = HomeInteractor()
    let presenter = HomePresenter()
    view.interactor = interactor
    interactor.presenter = presenter
    presenter.view = view

    return view
  }
}
