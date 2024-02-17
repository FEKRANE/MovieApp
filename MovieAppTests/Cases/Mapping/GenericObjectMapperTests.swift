//
//  GenericObjectMapperTests.swift
//  MovieAppTests
//
//  Created by FEKRANE on 13/2/2024.
//

@testable import MovieApp
import XCTest
import RxTest
import RxSwift

final class GenericObjectMapperTests: XCTestCase {
   
    func test_mapping_givenValidWSResponse_shouldSucceedWithExpectedMovie() throws {
        let expectedMovie = MovieListResponse.Movie(
            id: 713704,
            originalTitle: "Evil Dead Rise",
            posterPath: "/mIBCtPvKZQlxubxKMeViO2UrP3q.jpg",
            releaseDate: "2023-04-12",
            title: "Evil Dead Rise"
        )
        
        let data = try Data.fromJSON(fileName: "GET_Movie_Response")
        let mockedResponse: MovieListResponse.Movie = try GenericObjectMapper.map(data: data)
        
        XCTAssertEqual(mockedResponse, expectedMovie)
    }
    
    func test_mapping_withMissingPosterfield_shouldFail() throws {
        let data = try Data.fromJSON(fileName: "Invalid_Get_Movie_Response")
        let expectedError = "Failed to decode response: The data couldn’t be read because it is missing."
        
        XCTAssertThrowsError(try GenericObjectMapper.map(data: data) as MovieListResponse.Movie) { error in
            XCTAssertTrue(error is NetworkError)
            XCTAssertEqual(
                (error as? NetworkError)?.description,
                expectedError
            )
        }
    }
    
    func test_mapping_withErroResponse_shouldFail() throws {
        let data = try Data.fromJSON(fileName: "WS_Error_Response")
        let expectedError = "Custom API error: Invalid API key"
        
        XCTAssertThrowsError(try GenericObjectMapper.map(data: data) as MovieListResponse.Movie) { error in
            XCTAssertTrue(error is NetworkError)
            XCTAssertEqual(
                (error as? NetworkError)?.description,
                expectedError
            )
        }
    }
}
