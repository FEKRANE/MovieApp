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
    var url: URL { URL(string: "https://test.com")! }
    var header: [String:String] { ["Authorization": "Bearer TOKEN"] }
    var testScheduler: TestScheduler!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        urlSessionMock = MockURLSession()
        sut = NetworkManager(session: urlSessionMock)
        testScheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
        
    }

    override func tearDown() {
        urlSessionMock = nil
        sut = nil
        testScheduler = nil
        disposeBag = nil
        super.tearDown()
    }
    
    func test_request_setCorrectURL() {
        let testObserver = testScheduler.createObserver(Data.self)
        sut.request(
            url.absoluteString,
            queryParams: nil,
            httpMethod: .get,
            headers: nil
        ).asObservable()
            .subscribe(testObserver)
            .disposed(by: disposeBag)
        
        XCTAssertEqual(urlSessionMock.task.originalRequest?.url, url)
    }
    
    func test_request_setCorrectHeader() {
        let testObserver = testScheduler.createObserver(Data.self)
        sut.request(
            url.absoluteString,
            queryParams: nil,
            httpMethod: .get,
            headers: header
        ).asObservable()
            .subscribe(testObserver)
            .disposed(by: disposeBag)
        
        XCTAssertEqual(urlSessionMock.task.originalRequest?.allHTTPHeaderFields, header)
    }
    
    func test_request_calledResume() {
        let testObserver = testScheduler.createObserver(Data.self)
        sut.request(
            url.absoluteString,
            queryParams: nil,
            httpMethod: .get,
            headers: header
        ).asObservable()
            .subscribe(testObserver)
            .disposed(by: disposeBag)
        
        XCTAssertTrue(urlSessionMock.task.calledResume)
    }
    
    func test_request_setCorrectQueryParams() throws {
        let expectedParams = [
            "page": "1",
            "offset": "0"
        ]
        let testObserver = testScheduler.createObserver(Data.self)
        
        sut.request(
            url.absoluteString,
            queryParams: expectedParams,
            httpMethod: .get,
            headers: nil
        ).asObservable()
            .subscribe(testObserver)
            .disposed(by: disposeBag)
        
        let urlrequest = urlSessionMock.task.originalRequest
        let resultUrl = try XCTUnwrap(urlrequest?.url)

        let queryParms = URLComponents(
            url: resultUrl,
            resolvingAgainstBaseURL: false
        )?.queryItems
        
        XCTAssertEqual(queryParms?.count,expectedParams.count, "Query items count mismatch")
        
        for (key, value) in expectedParams {
            XCTAssertTrue(queryParms?.contains(where: { $0.name == key && $0.value == value }) ?? false, "\(key)=\(value) not found in query items")
        }
        
    }
    
    func test_request_givenInvalidURL_shouldFailWithError() {
        let invalidURL = "//:invalid url"
        let expectedError: NetworkError = .invalidURL(url: invalidURL)
        let testObserver = testScheduler.createObserver(Data.self)
        
        sut.request(
            invalidURL,
            queryParams: nil,
            httpMethod: .get,
            headers: nil
        ).asObservable()
            .subscribe(testObserver)
            .disposed(by: disposeBag)
        
        XCTAssertEqual(testObserver.events, [.error(0, expectedError)])
        
    } 
    
    func test_request_givenError_shouldFail() {
        let expectedError: NetworkError = .requestFailed
        let testObserver = testScheduler.createObserver(Data.self)
        let error = NSError(domain: "com.MovieApp",
                                        code: 42)
        sut.request(
            url.absoluteString,
            queryParams: nil,
            httpMethod: .get,
            headers: nil
        ).asObservable()
            .subscribe(testObserver)
            .disposed(by: disposeBag)
        
        
        urlSessionMock.completionHandler(nil, nil, error)
        
        XCTAssertEqual(testObserver.events, [.error(0, expectedError)])
        
    }
    
    func test_request_givenResponseStatusCode500_shouldFail() {
        let expectedError: NetworkError = .invalidResponse
        let testObserver = testScheduler.createObserver(Data.self)
    
        sut.request(
            url.absoluteString,
            queryParams: nil,
            httpMethod: .get,
            headers: nil
        ).asObservable()
            .subscribe(testObserver)
            .disposed(by: disposeBag)
        
        
        urlSessionMock.completionHandler(nil, response(statusCode: 500), nil)
        
        XCTAssertEqual(testObserver.events, [.error(0, expectedError)])
        
    }
    
    func test_request_givenResponseStatusCode401_shouldFail() {
        let expectedError: NetworkError = .tokenExpired
        let testObserver = testScheduler.createObserver(Data.self)
        
        sut.request(
            url.absoluteString,
            queryParams: nil,
            httpMethod: .get,
            headers: nil
        ).asObservable()
            .subscribe(testObserver)
            .disposed(by: disposeBag)
        
        
        urlSessionMock.completionHandler(nil, response(statusCode: 401), nil)
        
        XCTAssertEqual(testObserver.events, [.error(0, expectedError)])
        
    } 
    
    private func response(statusCode: Int) -> HTTPURLResponse? {
        HTTPURLResponse(url: url,
                        statusCode: statusCode, httpVersion: nil, headerFields: nil)
    }
}
