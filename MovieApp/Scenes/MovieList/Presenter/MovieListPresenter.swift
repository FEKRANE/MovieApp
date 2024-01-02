//
//  MovieListPresenter.swift
//  MovieApp
//
//  Created by FEKRANE on 27/12/2023.
//

import Foundation

protocol MovieListPresentationLogic {
  func showMovies(_ response: MovieList.Response)
  func showError(_ message: String)
}

final class MovieListPresenter {
  var view: (any MovieListDisplayLogic)?
}

extension MovieListPresenter: MovieListPresentationLogic {
    func showMovies(_ response: MovieList.Response) {
        let viewModel = constructMoviesViewModel(from: response)
        view?.displayMovies(viewModel: viewModel)
    }
    
    func showError(_ message: String) { }
    
}

//MARK: Helpers
func constructMoviesViewModel(from response: MovieList.Response) -> MovieList.ViewModel {
    let movieList = response.movieList
    let viewModel = MovieList.ViewModel()
    let movies = movieList.results.map {
        MovieList.ViewModel.Movie(
            poster:  URL(string: "https://image.tmdb.org/t/p/w400/\($0.posterPath)")!,
            releaseDate: $0.releaseDate,
            title: $0.title
        )
    }
    viewModel.movies = movies
    viewModel.page = movieList.page
    viewModel.totalPages = movieList.totalPages
    return viewModel
}
