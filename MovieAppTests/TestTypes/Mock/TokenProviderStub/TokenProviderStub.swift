//
//  TokenProviderStub.swift
//  MovieAppTests
//
//  Created by FEKRANE on 20/2/2024.
//

@testable import MovieApp
import Foundation
import RxSwift
import RxTest

final class TokenProviderStub: TokenProvider {
    var scheduler: TestScheduler

    init(scheduler: TestScheduler) {
        self.scheduler = scheduler
    }
    
    func tokenObservable() -> Observable<String> {
        Observable.of("test_token")
    }    
}
