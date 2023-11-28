//
//  GenericObjectMapper.swift
//  MovieApp
//
//  Created by FEKRANE on 27/11/2023.
//

import Foundation
import RxSwift

struct GenericObjectMapper {
    static func map<T>(data: Data) throws -> Single<T> where T: Decodable {
        return .create { single in
            do {
                let content = try JSONDecoder().decode(T.self, from: data)
                single(.success(content))
            } catch {
                single(.failure(NetworkError.decodingFailed(error: error)))
            }
                       
            return Disposables.create()
        }
    }
}
