//
//  MovieListModel.swift
//  MovieApp
//
//  Created by FEKRANE on 25/12/2023.
//

import Foundation

enum MovieList {
    struct Request {
        let page: Int
        let movieCategory: MovieCategory
        
        init(page: Int = 1, movieCategory: MovieCategory) {
            self.page = page
            self.movieCategory = movieCategory
        }
        
    }

    struct Response {
        let movieList: MovieListResponse
    }
    
    class ViewModel: ObservableObject {
        @Published var movies: [Movie] = []
        @Published var totalPages: Int = 0
        @Published var page: Int = 1
        
        struct Movie: Hashable & Identifiable {
            let id = UUID()
            let poster: URL
            let releaseDate: String
            let title: String
        }
        
        func refresh(movies: [Movie]) {
            self.movies = movies
        }
    }
}

