//
//  HomePresenter.swift
//  MovieApp
//
//  Created by FEKRANE on 29/12/2023.
//

import Foundation

protocol HomePresentationLogic {
    func showSections(_ response: [MovieCategory])
}

final class HomePresenter {
  var view: (any HomeDisplayLogic)?
}

extension HomePresenter: HomePresentationLogic {
    func showSections(_ response: [MovieCategory]) {
        view?.displaySection(sections: response)
    }
}
