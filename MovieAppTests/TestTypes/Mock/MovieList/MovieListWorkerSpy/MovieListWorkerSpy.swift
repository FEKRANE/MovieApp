//
//  MovieListWokerSpy.swift
//  MovieAppTests
//
//  Created by FEKRANE on 22/2/2024.
//
@testable import MovieApp
import Foundation

final class MovieListWorkerSpy: MovieListWorkerProtocol {
    
    var shouldFail = false
    var request: MovieListRequest!
    
    func getMovieList(request: MovieListRequest, completion: @escaping (Result<MovieListResponse, NetworkError>) -> Void) {
        self.request = request
        let result: Result<MovieListResponse, NetworkError> = if shouldFail {
            .failure(NetworkError.unexpected)
        } else {
            .success(MovieListResponse.fixture())
        }
        completion(result)
    }
    
}
