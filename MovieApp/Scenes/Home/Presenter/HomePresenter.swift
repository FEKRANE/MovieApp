//
//  HomePresenter.swift
//  MovieApp
//
//  Created by FEKRANE on 29/12/2023.
//

import Foundation

protocol HomePresentationLogic {
  func showSections(_ response: [String])
}

final class HomePresenter {
  var view: (any HomeDisplayLogic)?
}

extension HomePresenter: HomePresentationLogic {
    func showSections(_ response: [String]) {
        view?.displaySection(sections: response)
    }
}
