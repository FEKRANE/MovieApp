//
//  HttpClient.swift
//  MovieApp
//
//  Created by FEKRANE on 22/11/2023.
//

import Foundation
import RxSwift

protocol HttpClient {
    func request(
        _ url: String,
        queryParams: [String: String]?,
        httpMethod: HttpMethod,
        headers: HTTPHeaders
    ) -> Single<Data>
}

extension HttpClient {
    func request(
        _ url: String,
        queryParams: [String: String]? = nil,
        httpMethod: HttpMethod = .get,
        headers: HTTPHeaders
    ) -> Single<Data> {
        request(
            url,
            queryParams: queryParams,
            httpMethod: httpMethod,
            headers: headers
        )
    }
}

