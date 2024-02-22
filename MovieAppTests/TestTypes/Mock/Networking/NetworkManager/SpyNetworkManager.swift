//
//  FakeNetworkManager.swift
//  MovieAppTests
//
//  Created by FEKRANE on 20/2/2024.
//

@testable import MovieApp
import Foundation
import RxSwift

final class SpyNetworkManager: HttpClient {
    var headers: HTTPHeaders?
    var url: String?
    func request(
        _ url: String,
        queryParams: [String : String]?,
        httpMethod: HttpMethod,
        headers: HTTPHeaders?
    ) -> Single<Data> {
        return Single.create { [weak self] single in
            self?.headers = headers
            self?.url = url
            return Disposables.create()
        }
    }
}
