//
//  MovieListScreen.swift
//  MovieApp
//
//  Created by FEKRANE on 31/12/2023.
//

import SwiftUI

protocol MovieListDisplayLogic {
    func displayMovies(viewModel: MovieList.ViewModel)
}

struct MovieListScreen: View {
    @ObservedObject private var viewModel = MovieList.ViewModel()
    var interactor: (any MovieListBusinessLogic)?
    var movieCategory: MovieCategory
    
    init(movieCategory: MovieCategory = .topRatedMovies) {
        self.movieCategory = movieCategory
    }
    
    var body: some View {
        List(viewModel.movies, id: \.self) { movie in
            NavigationLink {
                //TODO: Redirect to movieDetails view
            } label: {
                HStack {
                    AsyncImage(url: movie.poster) { poster in
                        poster
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 60)
                    } placeholder: {
                        ProgressView()
                            .frame(width: 60)
                    }
                    
                    VStack(alignment: .leading) {
                        Text(movie.title)
                            .font(.subheadline)
                        Text(movie.releaseDate)
                            .font(.caption)
                            .lineLimit(3)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .listStyle(GroupedListStyle())
        .onAppear {
            let request = MovieList.Request(movieCategory: movieCategory)
            interactor?.fetchMovies(request: request)
        }
    }
}

extension MovieListScreen: MovieListDisplayLogic {
    func displayMovies(viewModel: MovieList.ViewModel) {
        self.viewModel.movies = viewModel.movies
        self.viewModel.totalPages = viewModel.totalPages
        self.viewModel.page = viewModel.page
    }
}

#Preview {
    MovieListScreen()
}
