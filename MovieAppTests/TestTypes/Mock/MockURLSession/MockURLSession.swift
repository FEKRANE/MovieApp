//
//  MockURLSession.swift
//  MovieAppTests
//
//  Created by FEKRANE on 11/2/2024.
//

@testable import MovieApp
import Foundation

class MockURLSession: URLSessionProtocol {
    
    private(set) var task = MockDataTask()
    
    func makeDataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionTaskProtocol {
        task.originalRequest = request
        return task
    }
    
}

class MockDataTask: URLSessionTaskProtocol {
    
    private(set) var calledResume = false
    var originalRequest: URLRequest?
    
    func resume() {
        calledResume = true
    }
    
    func cancel() {}
    
}
