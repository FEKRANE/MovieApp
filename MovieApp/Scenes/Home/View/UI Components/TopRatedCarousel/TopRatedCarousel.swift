//
//  TopRatedSection.swift
//  MovieApp
//
//  Created by FEKRANE on 11/12/2023.
//

import SwiftUI

struct MovieCarousel: View {
    @State private var currentIndex: Int = 0
    @GestureState private var dragOffset: CGFloat = 0
    var movies: [MovieList.ViewModel.Movie]
    var body: some View {
        let cardPadding = 60.0
        VStack {
            GeometryReader { geometry in
                Carousel(padding: cardPadding, items: movies) { movie in
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
    }
}


#Preview {
    let movies : [MovieList.ViewModel.Movie] = [
        .init(poster: URL(string: "https://image.tmdb.org/t/p/w400/kXfqcdQKsToO0OUXHcrrNCHDBzO.jpg")!, releaseDate: "1972-03-14", title: "he Godxfather"),
        .init(poster: URL(string: "https://image.tmdb.org/t/p/w400/kXfqcdQKsToO0OUXHcrrNCHDBzO.jpg")!, releaseDate: "1972-03-14", title: "he Godfather"),
        .init(poster: URL(string: "https://image.tmdb.org/t/p/w400/kXfqcdQKsToO0OUXHcrrNCHDBzO.jpg")!, releaseDate: "1972-03-14", title: "he Godfather"),
        .init(poster: URL(string: "https://image.tmdb.org/t/p/w400/kXfqcdQKsToO0OUXHcrrNCHDBzO.jpg")!, releaseDate: "1972-03-14", title: "he Godfather")
        
    ]
           
    return MovieCarousel(movies: movies)
        .frame(height: 300)
}

 struct CarouselItem: View {
    let geometry: GeometryProxy
    let cardPadding: CGFloat
    let imageUrl: URL
    
    var body: some View {
        let cardWidth = geometry.size.width - (cardPadding * 2)
        let cardHeight = geometry.size.height
        AsyncImage(url: imageUrl) { poster in
            poster
                .resizable()
//                .aspectRatio(contentMode: .fill)
        } placeholder: {
            ProgressView()
        }
        .frame(width: cardWidth, height: cardHeight)
        .clipped()
        .clipShape(.rect(cornerRadius: 12))
        .shadow(color: .black.opacity(0.25), radius: 8)
    }
}

