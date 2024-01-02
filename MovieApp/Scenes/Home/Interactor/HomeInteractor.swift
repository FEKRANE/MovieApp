//
//  HomeInteractor.swift
//  MovieApp
//
//  Created by FEKRANE on 29/12/2023.
//

import Foundation

protocol HomeBusinessLogic {
  func getSections()
}

final class HomeInteractor {
   var presenter: (any HomePresentationLogic)?
}

extension HomeInteractor: HomeBusinessLogic {
    func getSections() {
        let sections = [
            "Upcomming Movies",
            "Popular Movies"
        ]
        presenter?.showSections(sections)
    }
}
