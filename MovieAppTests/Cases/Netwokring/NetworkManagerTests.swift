//
//  NetworkManagerTests.swift
//  MovieAppTests
//
//  Created by FEKRANE on 11/2/2024.
//

@testable import MovieApp
import XCTest
import RxTest
import RxSwift

final class NetworkManagerTests: XCTestCase {
    
    var sut: NetworkManager!
    var urlSessionMock: MockURLSession!
    var url: String { "https://test.com" }
    var header: [String:String] { ["Authorization": "Bearer TOKEN"] }
    var testScheduler: TestScheduler!
    var disposeBag: DisposeBag!
    var testObserver: TestableObserver<Data>!
    
    override func setUp() {
        super.setUp()
        urlSessionMock = MockURLSession()
        sut = NetworkManager(session: urlSessionMock)
        testScheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
        testObserver = testScheduler.createObserver(Data.self)
    }

    override func tearDown() {
        urlSessionMock = nil
        sut = nil
        testScheduler = nil
        disposeBag = nil
        testObserver = nil
        super.tearDown()
    }
    
    func test_init_sets_session() {
        XCTAssertTrue(sut.session === urlSessionMock)
    }
    
    func test_request_setCorrectURL() {
        // given
        let expectedURL = URL(string: url)
       
        // when
        whenBuildRequest(url: url)
        
        // then
        XCTAssertEqual(urlSessionMock.task.originalRequest?.url, expectedURL)
    }
    
    func test_request_setCorrectHeader() {
        whenBuildRequest(url: url, headers: header)
        XCTAssertEqual(urlSessionMock.task.originalRequest?.allHTTPHeaderFields, header)
    }
    
    func test_request_calledResume() {
        whenBuildRequest(url: url)
        XCTAssertTrue(urlSessionMock.task.calledResume)
    }
    
    func test_request_setCorrectQueryParams() throws {
        let expectedParams = [
            "page": "1",
            "offset": "0"
        ]

        whenBuildRequest(url: url, queryParams: expectedParams)
       
        let urlrequest = urlSessionMock.task.originalRequest
        let resultUrl = try XCTUnwrap(urlrequest?.url)

        let queryParams = URLComponents(
            url: resultUrl,
            resolvingAgainstBaseURL: false
        )?.queryItems
        
        XCTAssertEqual(queryParams?.count,expectedParams.count, "Query items count mismatch")
        
        for (key, value) in expectedParams {
            XCTAssertTrue(queryParams?.contains(where: { $0.name == key && $0.value == value }) ?? false, "\(key)=\(value) not found in query items")
        }
        
    }
    
    func test_request_givenInvalidURL_shouldFailWithError() {
        let invalidURL = "//:invalid url"
        let expectedError: NetworkError = .invalidURL(url: invalidURL)
      
        whenBuildRequest(url: invalidURL)
        
        XCTAssertEqual(testObserver.events, [.error(0, expectedError)])
        
    } 
    
    func test_request_givenError_shouldFail() {
        let expectedError: NetworkError = .requestFailed
        let error = NSError(domain: "com.MovieApp",
                                        code: 42)
        
        whenBuildRequest(url: url)
        urlSessionMock.completionHandler(nil, nil, error)
        
        XCTAssertEqual(testObserver.events, [.error(0, expectedError)])
        
    }
    
    func test_request_givenResponseStatusCode500_shouldFail() {
        let expectedError: NetworkError = .invalidResponse
    
        whenBuildRequest(url: url)
        urlSessionMock.completionHandler(nil, response(statusCode: 500), nil)
        
        XCTAssertEqual(testObserver.events, [.error(0, expectedError)])
        
    }
    
    func test_request_givenResponseStatusCode401_shouldFail() {
        let expectedError: NetworkError = .tokenExpired
        
        whenBuildRequest(url: url)
        urlSessionMock.completionHandler(nil, response(statusCode: 401), nil)
        
        XCTAssertEqual(testObserver.events, [.error(0, expectedError)])
        
    } 
    
     func test_request_givenResponseStatusCode200_shouldReturnData() throws {
        
         let expectedData = try Data.fromJSON(fileName: "GET_Movie_Response")
         
        whenBuildRequest(url: url)
        urlSessionMock.completionHandler(expectedData, response(statusCode: 200), nil)
        
         XCTAssertEqual(testObserver.events, [.next(0, expectedData), .completed(0)])
    }
    
    private func response(statusCode: Int) -> HTTPURLResponse? {
        HTTPURLResponse(url: URL(string: url)!,
                        statusCode: statusCode, httpVersion: nil, headerFields: nil)
    }
    
    private func whenBuildRequest(
        url: String,
        queryParams: [String: String]? = nil,
        headers: HTTPHeaders? = nil
    ) {
        sut.request(
            url,
            queryParams: queryParams,
            httpMethod: .get,
            headers: headers
        ).asObservable()
            .subscribe(testObserver)
            .disposed(by: disposeBag)
    }
}
