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
    
    func test_NetworkManager_request_setCorrectURL() {
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
    
    func test_NetworkManager_request_setCorrectHeader() {
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
    
    func test_NetworkManager_request_setCorrectQueryParams() throws {
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
    
    
}
