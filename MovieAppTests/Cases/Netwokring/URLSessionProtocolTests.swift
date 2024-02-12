//
//  URLSessionProtocolTests.swift
//  MovieAppTests
//
//  Created by FEKRANE on 10/2/2024.
//

import XCTest
@testable import MovieApp

final class URLSessionProtocolTests: XCTestCase {
    
    var sut: URLSession!
    var urlRequest: URLRequest {
        URLRequest(url: URL(string: "https://test.com")!)
    }
    
    override func setUp() {
        super.setUp()
        sut = URLSession(configuration: .default)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_URLSession_conformsTo_URLSessionProtocol() {
        // cast sut as AnyObject to selence a compiler warning
        XCTAssertTrue((sut as AnyObject) is URLSessionProtocol)
    }
    
    func test_URLSessionTask_conformsTo_URLSessionTaskProtocol() {
        let dataTask = sut.dataTask(with: urlRequest)
        XCTAssertTrue((dataTask as AnyObject) is URLSessionTaskProtocol)
      }

    func test_URLSession_makeDataTask_setCorrectURL() {
        let expectedURL = urlRequest.url
        
        let dataTask = sut.makeDataTask(
            with: urlRequest,
            completionHandler: { _,_,_ in }
        ) as! URLSessionDataTask
        
        XCTAssertEqual(dataTask.originalRequest?.url, expectedURL)
    }
    
    func test_URLSession_makeDataTask_setCorrectCompletionHandler() {
        let expectation = expectation(description: "Completion should be called")
        
        let dataTask = sut.makeDataTask(
            with: urlRequest,
            completionHandler: { _,_,_ in expectation.fulfill() }
        )
        
        dataTask.cancel()
        
        waitForExpectations(timeout: 0.1)
    }
}
