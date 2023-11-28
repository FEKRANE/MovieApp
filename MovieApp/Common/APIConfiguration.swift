//
//  ApiConfiguration.swift
//  MovieApp
//
//  Created by FEKRANE on 27/11/2023.
//

import Foundation

protocol Configuration {
    var baseURL: String { get }
    var apiKey: String { get }
    var endpoint: String { get }
}

enum APIConfiguration {
    case refreshToken
}

extension APIConfiguration: Configuration {
    
    var baseURL: String {
        "https://api.themoviedb.org/3/"
    }
    
    var apiKey: String {
        "3d7810ad21cf0e5b82b0ccdebdc9d2d1"
    }
    
    var endpoint: String {
        switch self {
        case .refreshToken:
            return baseURL.appending("authentication/guest_session/new")
        }
    }
}
