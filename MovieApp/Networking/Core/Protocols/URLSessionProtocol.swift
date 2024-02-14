//
//  URLSessionProtocol.swift
//  MovieApp
//
//  Created by FEKRANE on 23/11/2023.
//

import Foundation

protocol URLSessionProtocol: AnyObject {
    typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
    func makeDataTask(
        with request: URLRequest,
        completionHandler: @escaping DataTaskResult
    ) -> URLSessionTaskProtocol
}

extension URLSessionTask: URLSessionTaskProtocol { }

extension URLSession: URLSessionProtocol {
    func makeDataTask(
        with request: URLRequest,
        completionHandler: @escaping (
            Data?,
            URLResponse?,
            Error?
        ) -> Void
    ) -> URLSessionTaskProtocol {
        return dataTask(
            with: request,
            completionHandler: completionHandler
        )
    }
}

protocol URLSessionTaskProtocol: AnyObject {
    func resume()
    func cancel()
}
