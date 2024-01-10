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


enum NetworkError: Error {
    case requestFailed
    case invalidResponse
    case invalidStatusCode(Int)
    case tokenExpired
    case invalidURL(url: String)
    case decodingFailed(error: Error)
    case customApiError(message: String)
    case unexpected
}

extension NetworkError {
    public var description: String {
        switch self {
        case .requestFailed:
            return "The network request failed."
        case .invalidResponse:
            return "Received an invalid response from the server."
        case .invalidStatusCode(let statusCode):
            return "Received an invalid status code: \(statusCode)."
        case .tokenExpired:
            return "The authentication token has expired."
        case .invalidURL(let url):
            return "Invalid URL: \(url)"
        case .decodingFailed(let error):
            return "Failed to decode response: \(error.localizedDescription)"
        case .customApiError(let message):
            return "Custom API error: \(message)"
        case .unexpected:
            return "An unexpected error occurred."
        }
    }
}

enum MovieCategory {
    case topRatedMovies
    case popular
    case upcoming
    
    var title: String {
        switch self {
        case .topRatedMovies:
            return "Top Rated Movies"
        case .popular:
            return "Popular Movies"
        case .upcoming:
            return "Upcoming Movies"
        }
    }
}
