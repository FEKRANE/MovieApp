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
    case upcommingMovies
    case topRatedMovies
    case popularMovies
}

extension APIConfiguration: Configuration {
    
    var baseURL: String {
        "https://api.themoviedb.org/3/"
    }
    
    var apiKey: String {
        "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmZDE4NDk3ODlhNTY2MmYzMjQ3YWQxNGJhYzY0NDhhZSIsInN1YiI6IjY0NmEwYjllMDA2YjAxMDEwNThhOTVjZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.WS4IFP2_rML53IE_BS1S6plMG0ZwQ2bMK9g2rgeYsUU"
    }
    
    var endpoint: String {
        switch self {
        case .refreshToken:
            return baseURL.appending("authentication/guest_session/new")
        case .upcommingMovies:
            return baseURL.appending("movie/upcoming")
        case .topRatedMovies:
            return baseURL.appending("movie/top_rated")
        case .popularMovies:
            return baseURL.appending("movie/popular")
        }
    }
}
