//
//  ApiErrorDto.swift
//  MovieApp
//
//  Created by FEKRANE on 25/12/2023.
//

import Foundation

struct ApiErrorDto: Decodable {
    let statusMessage: String
    let success: Bool
}
