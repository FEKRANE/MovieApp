//
//  MoviesListRS.swift
//  MovieApp
//
//  Created by FEKRANE on 20/12/2023.
//

import Foundation

struct MovieListResponse: Decodable {
    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int
    
    struct Movie: Decodable {
        let id: Int
        let originalTitle: String
        let posterPath: String
        let releaseDate: String
        let title: String
    }
}
