//
//  TopRatedSection.swift
//  MovieApp
//
//  Created by FEKRANE on 11/12/2023.
//

import SwiftUI

struct TopRatedCarousel: View {
    @State private var currentIndex: Int = 0
    @GestureState private var dragOffset: CGFloat = 0
    
    var body: some View {
        let cardPadding = 50.0
        VStack {
            GeometryReader { geometry in
                Carousel(padding: cardPadding,items: Array(1..<5)) { item in
                    CarouselItem(geometry: geometry, cardPadding: cardPadding)
                }
            }
            Spacer()
        }.padding(.vertical)
    }
}


#Preview {
    TopRatedCarousel()
        .frame(height: 300)
}

fileprivate struct CarouselItem: View {
    let geometry: GeometryProxy
    let cardPadding: CGFloat
    
    var body: some View {
        let cardWidth = geometry.size.width - (cardPadding * 2)
        let cardHeight = geometry.size.height
        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w400/7bWxAsNPv9CXHOhZbJVlj2KxgfP.jpg")) { poster in
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

