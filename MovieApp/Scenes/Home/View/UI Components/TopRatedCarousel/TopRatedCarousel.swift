//
//  TopRatedSection.swift
//  MovieApp
//
//  Created by FEKRANE on 11/12/2023.
//

import SwiftUI

extension TopRatedCarousel: MovieListDisplayLogic {
    func displayMovies(viewModel: MovieList.ViewModel) {
        self.viewModel.movies = viewModel.movies
    }
    
    func fetchTopRatedMovies() {
        let request = MovieList.Request(movieCategory: .topRatedMovies)
        interactor?.fetchMovies(request: request)
    }
}

struct TopRatedCarousel: View {
    @State private var currentIndex: Int = 0
    @GestureState private var dragOffset: CGFloat = 0
    var interactor: MovieListInteractor?
    @ObservedObject var viewModel = MovieList.ViewModel()
    var body: some View {
        let cardPadding = 50.0
        VStack {
            GeometryReader { geometry in
                Carousel(padding: cardPadding, items: viewModel.movies) { movie in
                    CarouselItem(
                        geometry: geometry,
                        cardPadding: cardPadding,
                        imageUrl: movie.poster
                    )
                }
            }
            Spacer()
        }
        .padding(.vertical)
        .onAppear {
            fetchTopRatedMovies()
        }
    }
}


#Preview {
    TopRatedCarousel()
        .frame(height: 300)
}

fileprivate struct CarouselItem: View {
    let geometry: GeometryProxy
    let cardPadding: CGFloat
    let imageUrl: URL
    
    var body: some View {
        let cardWidth = geometry.size.width - (cardPadding * 2)
        let cardHeight = geometry.size.height
        AsyncImage(url: imageUrl) { poster in
            poster
                .resizable()
                .aspectRatio(contentMode: .fill)
        } placeholder: {
            ProgressView()
        }
        .frame(width: cardWidth, height: cardHeight)
        .clipped()
        .clipShape(.rect(cornerRadius: 12))
        .shadow(color: .black.opacity(0.25), radius: 8)
    }
}

