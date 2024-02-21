//
//  MoviesListRS.swift
//  MovieApp
//
//  Created by FEKRANE on 20/12/2023.
//

import Foundation

struct MovieListResponse: Decodable, Equatable {
    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int
    
    struct Movie: Decodable, Equatable {
        let id: Int
        let originalTitle: String
        let posterPath: String
        let releaseDate: String
        let title: String
        
        static func == (lhs: MovieListResponse.Movie, rhs: MovieListResponse.Movie) -> Bool {
            return lhs.id == rhs.id &&
            lhs.originalTitle == rhs.originalTitle &&
            lhs.posterPath == rhs.posterPath &&
            lhs.releaseDate == rhs.releaseDate &&
            lhs.title == rhs.title
        }
    }
    
    static func == (lhs: MovieListResponse, rhs: MovieListResponse) -> Bool {
        return lhs.page == rhs.page &&
        lhs.results == rhs.results &&
        lhs.totalPages == rhs.totalPages &&
        lhs.totalResults == rhs.totalResults
    }
}
