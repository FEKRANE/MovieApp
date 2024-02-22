//
//  MoviePresenterSpy.swift
//  MovieAppTests
//
//  Created by FEKRANE on 21/2/2024.
//

@testable import MovieApp
import Foundation

final class MovieListPresenterSpy : MovieListPresentationLogic {

    typealias MovieListRS = MovieList.Response
    
    // MARK: Method call expectations
    var presentMoviesCalled = false
    var presentErrorCalled = false
    var movieList: MovieListResponse?
    var errorMessage: String?
    
    func showMovies(_ response: MovieListRS) {
        presentMoviesCalled = true
        movieList = response.movieList
    }
    
    func showError(_ message: String) {
        presentErrorCalled = true
        errorMessage = message
    }
    
}
