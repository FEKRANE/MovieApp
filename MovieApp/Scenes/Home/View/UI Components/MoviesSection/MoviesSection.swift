//
//  MoviesSection.swift
//  MovieApp
//
//  Created by FEKRANE on 29/11/2023.
//

import Foundation
import SwiftUI

extension MoviesSection: MovieListDisplayLogic {
    func displayMovies(viewModel: MovieList.ViewModel) {
        self.viewModel.movies = viewModel.movies
    }
    
    func fetchMovies() {
        let request = MovieList.Request(movieCategory: categorie)
        interactor?.fetchMovies(request: request)
    }
}

struct MoviesSection: View {
    let categorie: MovieCategory
    var interactor: (any MovieListBusinessLogic)?
    @ObservedObject var viewModel : MovieList.ViewModel

    var body: some View {
        Group {
            if categorie == .topRatedMovies {
                MovieCarousel(movies: viewModel.movies)
            } else {
                MovieListView(
                    movies: viewModel.movies,
                    categorie: categorie
                )
            }
        }
        .onAppear {
            fetchMovies()
        }
    }
}


#Preview {
    MoviesSection(categorie: .topRatedMovies, viewModel: .init())
        .frame(height: 220)
}

struct MovieListView: View {
    var movies: [MovieList.ViewModel.Movie]
    var categorie: MovieCategory
    @EnvironmentObject var coordinator: MainCoordinator

    var body: some View {
        VStack {
            HStack {
                Text(categorie.title)
                    .font(.title2)
                Spacer()
                Button(action: {
                    coordinator.show(Route.movieList(category: categorie))
                }, label: {
                    Text("See more")
                        .font(.caption)
                        .foregroundStyle(Color(.lightGray))
                        .padding(.horizontal,8)
                        .padding(.vertical,3)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color(.lightGray), lineWidth: 1)
                        )
                })
            }
            
            ScrollView(.horizontal,showsIndicators: false) {
                LazyHStack(spacing: 12) {
                    ForEach(movies,id: \.self){ movie in
                        MovieCell(selection: {}, imageUrl: movie.poster)
                    }
                }
            }
        }.padding()
    }
}
