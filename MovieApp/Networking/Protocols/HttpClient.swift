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
        httpMethod: HttpMethod
    ) -> Single<(HTTPURLResponse, Data)>
}
