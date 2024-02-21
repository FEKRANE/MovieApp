//
//  MovieListWorkerTests.swift
//  MovieAppTests
//
//  Created by FEKRANE on 19/2/2024.
//

@testable import MovieApp
import XCTest
import RxTest
import RxSwift

final class MovieListWorkerTests: XCTestCase {

    var sut: MovieListWorker!
    var testScheduler: TestScheduler!
    var disposeBag: DisposeBag!
    var spyNetworkManager: SpyNetworkManager!

    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
        testScheduler = TestScheduler(initialClock: 0)
        spyNetworkManager = SpyNetworkManager()
        sut = MovieListWorker(
            httpClient: spyNetworkManager,
            tokenProvider: TokenProviderStub(scheduler: testScheduler)
        )
    }

    override func tearDown() {
        disposeBag = nil
        testScheduler = nil
        spyNetworkManager = nil
        sut = nil
        super.tearDown()
    }

    func test_getMovieList_givenRequest_setsCorrectHeader() {
        let expectedHeader = [
            "Authorization": "Bearer test_token"
        ]
        let request = MovieListRequest(page: 1, movieCategory: .topRatedMovies)

        sut.getMovieList(request: request, completion: { _ in })
        
        XCTAssertEqual(spyNetworkManager.headers, expectedHeader)
    }
    
    func test_getMovieList_givenRequest_setsCorrectEndpoint() {
        let endpointMappings: [MovieCategory: String] = [
            .popular: APIConfiguration.popularMovies.endpoint,
            .topRatedMovies: APIConfiguration.topRatedMovies.endpoint,
            .upcoming: APIConfiguration.upcomingMovies.endpoint
        ]

        for (category, expectedEndpoint) in endpointMappings {
            verifyGetMovieListSetsCorrectUrl(category, expectedEndpoint)
        }
    }

    func test_getMovieList_givenSuccessResponse_shouldReturnMovieList() {
        let movie = MovieListResponse.Movie(id: 1, originalTitle: "test", posterPath: "poster", releaseDate: "01/02/2024", title: "test")
        let expectedResponse = MovieListResponse(page: 1, results: [movie], totalPages: 1, totalResults: 1)

        sut.responseProvider = { _, _, _ in
            Single.just(expectedResponse)
        }
        let (response, error) = whenBuildRequest()

        XCTAssertNil(error, "Error should be nil")
        XCTAssertEqual(response, expectedResponse)
        XCTAssertEqual(response?.page, expectedResponse.page)
        XCTAssertEqual(response?.results.count, expectedResponse.results.count)
    }
    
    func test_getMovieList_givenErrorResponse_shouldReturnError() {
        sut.responseProvider = { _, _, _ in
            Single.error(NSError(domain: "com.MovieApp", code: 404, userInfo: nil))
        }
        let expectedError = NetworkError.unexpected
        
        let (response, error) = whenBuildRequest()
        
        XCTAssertNil(response, "Response should be nil")
        XCTAssertNotNil(error, "Error should not be nil")
        XCTAssertEqual(error, expectedError)
    }

    
   private func verifyGetMovieListSetsCorrectUrl(_ category: MovieCategory, _ expectedEndpoint: String, line: UInt = #line) {
        let request = MovieListRequest(page: 1, movieCategory: category)

        sut.getMovieList(request: request, completion: { _ in })
        
        XCTAssertEqual(spyNetworkManager.url, expectedEndpoint, line: line)
    }

    private func whenBuildRequest() -> (MovieListResponse?, NetworkError?) {
        let request = MovieListRequest(page: 1, movieCategory: .topRatedMovies)
        var response: MovieListResponse?
        var error: NetworkError?
      
        sut.getMovieList(request: request) { result in
            switch result {
            case .success(let data):
                response = data
            case .failure(let err):
                error = err
            }
        }
        return (response, error)
    }
}
