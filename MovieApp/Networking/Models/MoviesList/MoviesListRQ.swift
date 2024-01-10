//
//  MoviesListModel.swift
//  MovieApp
//
//  Created by FEKRANE on 20/12/2023.
//

import Foundation

struct MovieListRequest: Encodable {
    let includeAdult: Bool = false
    let language: String = "en-US"
    let page: Int
    let sortBy: String = "popularity.desc"
    let movieCategory: MovieCategory
    
    private enum CodingKeys: String, CodingKey {
        case includeAdult = "include_adult"
        case language
        case page
        case sortBy = "sort_by"
    }
}
