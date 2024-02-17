//
//  NetworkManagerStub.swift
//  MovieAppTests
//
//  Created by FEKRANE on 15/2/2024.
//

@testable import MovieApp
import Foundation
import RxSwift

class NetworkManagerStub: HttpClient {

    typealias Token = RefreshTokenService.AccessToken
    
    var token: String?
    var error: NetworkError?
    
    func retrieve() throws -> String? {
        if let error  {
            throw error
        } else {
            return token
        }
    }
    
    func request(
        _ url: String,
        queryParams: [String : String]?,
        httpMethod: HttpMethod,
        headers: HTTPHeaders?
    ) -> Single<Data> {
        return Single.create { [weak self] single in
            guard let self else { return Disposables.create() }
            
            if let error {
                single(.failure(error))
            }
            
            let accessToken = Token(guestSessionId: token!, expiresAt: Date())
           
            if let data = try? dataFrom(token: accessToken) {
                single(.success(data))
            } else {
                single(.failure(NSError()))
            }
            
            return Disposables.create()
        }
    }
    
    private func dataFrom(token: Token) throws -> Data  {
        let encoder = JSONEncoder()
        return try encoder.encode(token)
    }
}
