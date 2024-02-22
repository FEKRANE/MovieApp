//
//  MovieListResponse+Fixtures.swift
//  MovieAppTests
//
//  Created by FEKRANE on 22/2/2024.
//

@testable import MovieApp
import Foundation

extension MovieListResponse {
    static func fixture(page: Int = 1, results: [Movie] = [Movie.fixture()], totalPages: Int = 1, totalResults: Int = 1) -> MovieListResponse {
        return MovieListResponse(page: page, results: results, totalPages: totalPages, totalResults: totalResults)
    }
}

extension MovieListResponse.Movie {
    static func fixture(id: Int = 1, originalTitle: String = "Title", posterPath: String = "", releaseDate: String = "", title: String = "Title") -> MovieListResponse.Movie {
        return MovieListResponse.Movie(id: id, originalTitle: originalTitle, posterPath: posterPath, releaseDate: releaseDate, title: title)
    }
}
