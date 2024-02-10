//
//  URLSessionProtocolTests.swift
//  MovieAppTests
//
//  Created by FEKRANE on 10/2/2024.
//

import XCTest

final class URLSessionProtocolTests: XCTestCase {
    
    var sut: URLSession!
    
    override func setUpWithError() throws {
        
        let sut = URLSession(configuration: .default)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

//    func testURLSession_conform
    
    func testExample() throws {
        XCTFail()
       
    }


}
