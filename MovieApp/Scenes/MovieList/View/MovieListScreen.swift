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
    @EnvironmentObject var coordinator: MainCoordinator
    
    init(movieCategory: MovieCategory = .topRatedMovies) {
        self.movieCategory = movieCategory
    }
    
    var body: some View {
        List(viewModel.movies, id: \.self, rowContent: row(movie:))
            .frame(maxWidth: .infinity)
            .listStyle(PlainListStyle())
            .onAppear {
                UITableView.appearance().backgroundColor = .background
                let request = MovieList.Request(movieCategory: movieCategory)
                interactor?.fetchMovies(request: request)
            }
    }
    
    @ViewBuilder
    func row(movie: MovieList.ViewModel.Movie) -> some View {
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
        .contentShape(Rectangle())
        .onTapGesture {
            coordinator.show(Route.movieDetail)
        }
    }
}

extension MovieListScreen: MovieListDisplayLogic {
    func displayMovies(viewModel: [MovieList.ViewModel.Movie]) {
        self.viewModel.movies = viewModel
        
    }
    
    func displayMovies(viewModel: MovieList.ViewModel) {
        self.viewModel.movies = viewModel.movies
        self.viewModel.totalPages = viewModel.totalPages
        self.viewModel.page = viewModel.page
    }
}

#Preview {
    MovieListScreen(movieCategory: .topRatedMovies)
}
