//
//  GenericObjectMapper.swift
//  MovieApp
//
//  Created by FEKRANE on 27/11/2023.
//

import Foundation
import RxSwift

struct GenericObjectMapper {
    static func map<T>(data: Data) throws -> T where T: Decodable {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            return try jsonDecoder.decode(T.self, from: data)
        } catch {
            if let error = try? jsonDecoder.decode(ApiErrorDto.self, from: data) {
                throw NetworkError.customApiError(message: error.statusMessage)
            } else {
                throw NetworkError.decodingFailed(error: error)
            }
        }
    }
}
