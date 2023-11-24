//
//  Enums.swift
//  MovieApp
//
//  Created by FEKRANE on 23/11/2023.
//

import Foundation

enum HttpMethod: String {
    case get
    case post
    var method: String { rawValue.uppercased() }
}

