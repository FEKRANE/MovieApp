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

extension NetworkError: Equatable {
    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.requestFailed, .requestFailed),
            (.invalidResponse, .invalidResponse),
            (.tokenExpired, .tokenExpired),
            (.unexpected, .unexpected):
            return true
        case let (.invalidStatusCode(code1), .invalidStatusCode(code2)):
            return code1 == code2
        case let (.invalidURL(url1), .invalidURL(url2)):
            return url1 == url2
        case let (.decodingFailed(error1), .decodingFailed(error2)):
            return "\(error1)" == "\(error2)"
        case let (.customApiError(message1), .customApiError(message2)):
            return message1 == message2
        default:
            return false
        }
    }
}

enum MovieCategory: CaseIterable {
    case topRatedMovies
    case popular
    case upcoming
    
    var title: String {
        switch self {
        case .topRatedMovies: "Top Rated Movies"
        case .popular: "Popular Movies"
        case .upcoming: "Upcoming Movies"
        }
    }
}
