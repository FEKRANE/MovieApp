//
//  NetworkManger.swift
//  MovieApp
//
//  Created by FEKRANE on 23/11/2023.
//

import Foundation
import RxSwift

class NetworkManager {
    
    //MARK: Properties
    static let sharedInstance = NetworkManager()
    private var session: URLSessionProtocol!

    enum ManagerErrors: Error {
        case requestFailed
        case invalidResponse
        case invalidStatusCode(Int)
        case tokenExpired
        case invalidURL(url: String)
    }
    
    //MARK: Initializers
    init(session: URLSessionProtocol? = nil) {
        self.session = session ?? initializeSession()
    }
    
    
   private func request(from url: String, queryParams: [String: String]? = nil, httpMethod: HttpMethod = .get) -> Single<(HTTPURLResponse, Data)> {
        
        return Single.create { single in
            
            var urlComponents = URLComponents(string: url)!
            
            if let queryParams = queryParams{
                urlComponents.queryItems = [URLQueryItem]()
                for (key, value) in queryParams{
                    urlComponents.queryItems?.append(URLQueryItem(name: key, value: value))
                }
            }
            
            var request = URLRequest(url: urlComponents.url!)
            request.httpMethod = httpMethod.method
            
            let dataTask = self.session.makeDataTask(with: request) { data, response, error in
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    single(.failure(ManagerErrors.requestFailed))
                    return
                }
                
                if (200..<300) ~= httpResponse.statusCode {
                    single(.success((httpResponse,data!)))
                } else if httpResponse.statusCode == 401 {
                    single(.failure(ManagerErrors.tokenExpired))
                } else {
                    single(.failure(ManagerErrors.invalidResponse))
                }
            }
            
            dataTask.resume()
            
            return Disposables.create {
                dataTask.cancel()
            }
            
        }
    }
}

//MARK: Helpers
extension NetworkManager {
    private func initializeSession()-> URLSessionProtocol {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 720
        configuration.timeoutIntervalForResource = 720
        return URLSession(
            configuration: configuration,
            delegate: nil,
            delegateQueue: nil
        )
    }
    
    private func prepareUrlRequest(url: String, queryParams: [String: String]?, httpMethod: HttpMethod) throws -> URLRequest {
        guard var urlComponents = URLComponents(string: url) else {
            throw ManagerErrors.invalidURL(url: url)
        }
        
        if let queryParams = queryParams {
            urlComponents.queryItems = [URLQueryItem]()
            for (key, value) in queryParams{
                urlComponents.queryItems?.append(URLQueryItem(name: key, value: value))
            }
        }
 
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = httpMethod.method
        
        return request
    }
}


//MARK: - HttpClient Protocol
extension NetworkManager: HttpClient {
    func request(
        _ url: String,
        queryParams: [String : String]?,
        httpMethod: HttpMethod
    ) -> Single<(HTTPURLResponse, Data)> {
        return self.request(
            from: url,
            queryParams: queryParams,
            httpMethod: httpMethod
        )
    }
}
