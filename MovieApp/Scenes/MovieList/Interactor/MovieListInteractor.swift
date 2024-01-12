//
//  MovieListInteractor.swift
//  MovieApp
//
//  Created by FEKRANE on 27/12/2023.
//

import Foundation

protocol MovieListBusinessLogic {
    func fetchMovies(request: MovieList.Request)
}

final class MovieListInteractor {
    var presenter: (any MovieListPresentationLogic)?
    private var worker: (any MovieListWorkerProtocol)?
    init(worker: MovieListWorkerProtocol = MovieListWorker()) {
        self.worker = worker
    }
}

extension MovieListInteractor: MovieListBusinessLogic {
    func fetchMovies(request: MovieList.Request) {
        let requestModel = MovieListRequest(
            page: request.page,
            movieCategory: request.movieCategory
        )
        worker?.getMovieList(request: requestModel) { [weak self] result in
            switch result {
            case .success(let data):
                let response = MovieList.Response(movieList: data)
                self?.presenter?.showMovies(response)
            case .failure(let error):
                self?.presenter?.showError(error.localizedDescription)
            }
        }
    }
}

