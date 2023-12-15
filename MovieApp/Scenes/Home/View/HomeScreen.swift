//
//  HomeScreen.swift
//  MovieApp
//
//  Created by FEKRANE on 29/11/2023.
//

import SwiftUI

struct HomeScreen: View {
    @State private var movieSearch = ""
    
    var body: some View {
            NavigationView {
                ZStack {
                    Color(.background)
                        .ignoresSafeArea(.all)
                    VStack {
                        TopRatedCarousel()
                        ForEach((1...2), id: \.self) { _ in
                            MoviesSection(title: "Upcomming movies")
                        }
                    }
                    .navigationTitle("What would you like to watch?")
                    .navigationBarTitleDisplayMode(.inline)
                }
            }
            .searchable(text: $movieSearch)
        }
}

#Preview {
    HomeScreen()
}

