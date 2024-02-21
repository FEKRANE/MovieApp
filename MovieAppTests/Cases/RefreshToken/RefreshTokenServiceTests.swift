//
//  RefreshTokenServiceTests.swift
//  MovieAppTests
//
//  Created by FEKRANE on 15/2/2024.
//

@testable import MovieApp
import XCTest
import RxTest
import RxSwift

final class RefreshTokenServiceTests: XCTestCase {

    var sut: RefreshTokenService!
    var networkManagerStub: NetworkManagerStub!
    var testScheduler: TestScheduler!
    var disposeBag: DisposeBag!
    var token: String { "test_token" }
    
    override func setUp() {
        super.setUp()
        networkManagerStub = NetworkManagerStub()
        testScheduler = TestScheduler(initialClock: 0)
        networkManagerStub.token = token
        sut = RefreshTokenService(apiManager: networkManagerStub, scheduler: testScheduler)
        disposeBag = DisposeBag()
    }

    override func tearDown() {
        sut = nil
        networkManagerStub = nil
        testScheduler = nil
        disposeBag = nil
        super.tearDown()
    }
    

    func test_tokenObservable_beforeThreshold_EmitsApiKey() {
        let testObserver = testScheduler.createObserver(String.self)
        let expectedToken = APIConfiguration.refreshToken.apiKey
        
        sut.tokenObservable()
            .subscribe(testObserver)
            .disposed(by: disposeBag)
        
        XCTAssertEqual(testObserver.events, [Recorded.next(0, expectedToken), .completed(0)])
    } 
    
    func test_tokenObservable_afterThreshold_givenValidResponse_EmitsNewToken() {
        let testObserver = testScheduler.createObserver(String.self)

        testScheduler.advanceTo(sut.refreshThreshold)
        
        sut.tokenObservable()
            .subscribe(testObserver)
            .disposed(by: disposeBag)
        
        XCTAssertEqual(testObserver.events, [Recorded.next(sut.refreshThreshold, token), .completed(sut.refreshThreshold)])
    }
    
    func test_tokenObservable_afterThreshold_givenErrorResponse_EmitsApiKey() {
        let testObserver = testScheduler.createObserver(String.self)
        let expectedToken = APIConfiguration.refreshToken.apiKey
        
        networkManagerStub.error =  NetworkError.invalidResponse
        
        testScheduler.advanceTo(sut.refreshThreshold)
        sut.tokenObservable()
            .subscribe(testObserver)
            .disposed(by: disposeBag)
        
        XCTAssertEqual(testObserver.events, [Recorded.next(sut.refreshThreshold, expectedToken), .completed(sut.refreshThreshold)])
    }

}
