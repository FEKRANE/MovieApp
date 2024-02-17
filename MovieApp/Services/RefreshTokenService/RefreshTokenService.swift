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
    
    struct AccessToken: Codable {
        let guestSessionId: String
        let expiresAt: Date
    }
    
    
    
    // MARK: Properties
    private let apiManager: any HttpClient
    private let token = BehaviorSubject<String>(value: APIConfiguration.refreshToken.apiKey)
    private let disposeBag = DisposeBag()
    let refreshThreshold: Int = 120
    private let headers = [
        "accept": "application/json",
        "Authorization": "Bearer \(APIConfiguration.refreshToken.apiKey)"
    ]
    
    // MARK: Initializers
    init(apiManager: HttpClient = NetworkManager.sharedInstance, scheduler: SchedulerType = MainScheduler.instance) {
        self.apiManager = apiManager
        Observable<Int>.interval(.seconds(refreshThreshold), scheduler: scheduler)
            .flatMapLatest { [headers] _ -> Single<AccessToken> in
                let url = APIConfiguration.refreshToken.endpoint
                return self.apiManager.request(url, headers: headers)
                    .map(GenericObjectMapper.map)
                    .retry(3)
            }
            .subscribe(
                onNext: { [weak self] accessToken in
                    self?.token.onNext(accessToken.guestSessionId)
                },
                onError: { error in
                    //TODO: Log error
                    self.token.onNext(APIConfiguration.refreshToken.apiKey)
                })
            .disposed(by: disposeBag)
    }
    
    func tokenObservable() -> Observable<String> {
        token.take(1)
            .asObservable()
    }
    
}



