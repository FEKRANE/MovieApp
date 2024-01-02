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
        
        init(page: Int = 1) {
            self.page = page
        }
    }
    
    struct Response {
        let movieList: MovieListResponse
    }
    
    class ViewModel: ObservableObject {
        @Published var movies: [Movie] = []
        @Published var totalPages: Int = 0
        @Published var page: Int = 1
        
        struct Movie: Identifiable {
            let id = UUID()
            let poster: URL
            let releaseDate: String
            let title: String
        }
    }
}

