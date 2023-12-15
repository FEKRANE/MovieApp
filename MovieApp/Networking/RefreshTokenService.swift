//
//  RefreshTokenManager.swift
//  MovieApp
//
//  Created by FEKRANE on 27/11/2023.
//

import Foundation
import RxSwift

protocol TokenProvider {
    func tokenObservable() -> Observable<String>
}

final class RefreshTokenService: TokenProvider {
    
    private struct AccessToken: Decodable {
        let accessToken: String
        let expiresAt: Date
        
        enum CodingKeys: String, CodingKey {
            case accessToken = "guest_session_id"
            case expiresAt = "expires_at"
        }
    }
    
    //MARK: Properties
    private let apiManager: any HttpClient
    private let token = ReplaySubject<String>.create(bufferSize: 1)
    private let disposeBag = DisposeBag()
    private let refreshThreshold: Int = 60
    private let headers = [
        "accept": "application/json",
        "Authorization": "Bearer \(APIConfiguration.refreshToken.apiKey)"
    ]
    
    //MARK: Initializers
    init(apiManager: HttpClient = NetworkManager.sharedInstance) {
        self.apiManager = apiManager
        Observable<Int>.interval(.seconds(refreshThreshold), scheduler: MainScheduler.instance)
            .flatMapLatest { [headers] _ -> Single<AccessToken> in
                let url = APIConfiguration.refreshToken.endpoint
                return apiManager.request(url, headers: headers)
                    .flatMap( GenericObjectMapper.map )
                    .retry(3)
            }
            .subscribe(
                onNext: { [weak self] accessToken in
                    self?.token.onNext(accessToken.accessToken)
                },
                onError: { error in
                    //TODO: Log error
                    self.token.onNext(APIConfiguration.refreshToken.apiKey)
                })
            .dispose()
    }
    
    func tokenObservable() -> Observable<String> {
        token.asObservable()
    }
    
}



