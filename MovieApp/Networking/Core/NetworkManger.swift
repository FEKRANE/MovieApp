//
//  NetworkManger.swift
//  MovieApp
//
//  Created by FEKRANE on 23/11/2023.
//

import Foundation
import RxSwift

typealias HTTPHeaders = [String: String]

final class NetworkManager {
    
    // MARK: Properties
    static let sharedInstance = NetworkManager()
    private let session: any URLSessionProtocol
    
    // MARK: Initializers
    init(session: some URLSessionProtocol) {
        self.session = session
    }
    
    init() {
        self.session = Self.initializeSession()
    }
    
   private func request(from url: String, queryParams: [String: String]? = nil, httpMethod: HttpMethod = .get, headers: HTTPHeaders? = nil) -> Single<Data> {
        return Single.create { single in
            
            guard var request = self.prepareUrlRequest(url, with: queryParams, method: httpMethod) else {
                single(.failure(NetworkError.invalidURL(url: url)))
                return Disposables.create()
            }
            
            headers?.forEach({
                request.setValue($0.value, forHTTPHeaderField: $0.key)
            })
                            
            let dataTask = self.session.makeDataTask(with: request) { data, response, error in
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    single(.failure(NetworkError.requestFailed))
                    return
                }
                
                if (200..<300) ~= httpResponse.statusCode {
                    single(.success(data!))
                } else if httpResponse.statusCode == 401 {
                    single(.failure(NetworkError.tokenExpired))
                } else {
                    single(.failure(NetworkError.invalidResponse))
                }
            }
            
            dataTask.resume()
            
            return Disposables.create {
                dataTask.cancel()
            }
            
        }
        .observe(on: MainScheduler.instance)
    }
}

// MARK: Helpers
extension NetworkManager {
    private static func initializeSession()-> some URLSessionProtocol {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 720
        configuration.timeoutIntervalForResource = 720
        return URLSession(
            configuration: configuration,
            delegate: nil,
            delegateQueue: nil
        )
    }
    
    /// Build Request
    private func prepareUrlRequest(_ url: String, with queryParams: [String: String]?, method httpMethod: HttpMethod) -> URLRequest? {
        guard var urlComponents = URLComponents(string: url) else {
            return nil
        }
        
        if let queryParams = queryParams {
            urlComponents.queryItems = [URLQueryItem]()
            for (key, value) in queryParams{
                urlComponents.queryItems?.append(
                    URLQueryItem(
                        name: key,
                        value: value
                    )
                )
            }
        }
 
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = httpMethod.method
        
        return request
    }
}


// MARK: - HttpClient Protocol
extension NetworkManager: HttpClient {
    func request(
        _ url: String,
        queryParams: [String : String]?,
        httpMethod: HttpMethod,
        headers: HTTPHeaders?
    ) -> Single<Data> {
        return self.request(
            from: url,
            queryParams: queryParams,
            httpMethod: httpMethod,
            headers: headers
        )
    }
}
