//
//  MovieListInteractorTests.swift
//  MovieAppTests
//
//  Created by FEKRANE on 21/2/2024.
//

@testable import MovieApp
import XCTest

final class MovieListInteractorTests: XCTestCase {
    
    var sut: MovieListInteractor!
    var workerSpy: MovieListWorkerSpy!
    var presenterSpy: MovieListPresenterSpy!

    override func setUp() {
        super.setUp()
        workerSpy = MovieListWorkerSpy()
        sut = MovieListInteractor(worker: workerSpy)
        presenterSpy = MovieListPresenterSpy()
        sut.presenter = presenterSpy

    }

    override func tearDown() {
        workerSpy = nil
        presenterSpy = nil
        sut = nil
        super.tearDown()
    }

    func test_fetchMovies_callsWorkerWithCorrectRequest() {
        let expectedRequest = MovieListRequest(
            page: 1,
            movieCategory: .popular
        )
        
        sut.fetchMovies(
            request: MovieList.Request(
                movieCategory: .popular
            )
        )
        
        XCTAssertEqual(expectedRequest, workerSpy.request)
        
    }
    
    func test_fetchMovies_givenData_CallsPresenterToPresentMovieList() {
        let expectedMovieList = MovieListResponse.fixture()
        
        sut.fetchMovies(
            request: MovieList.Request(
                movieCategory: .popular
            )
        )
        
        XCTAssertTrue(presenterSpy.presentMoviesCalled)
        XCTAssertEqual(presenterSpy.movieList, expectedMovieList)
        
    }
    
    func test_fetchMovies_givenError_CallsPresenterToDisplayErrorMsg() {
        workerSpy.shouldFail = true
        let expectedMsg = NetworkError.unexpected.description
        
        sut.fetchMovies(
            request: MovieList.Request(
                movieCategory: .popular
            )
        )
        
        XCTAssertTrue(presenterSpy.presentErrorCalled)
        XCTAssertEqual(presenterSpy.errorMessage, expectedMsg)
        
    }

}
