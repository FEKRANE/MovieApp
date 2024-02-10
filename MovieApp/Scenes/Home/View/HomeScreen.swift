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
                ScrollView(showsIndicators: false) {
                    VStack {
                        ForEach(MovieCategory.allCases, id: \.self) { section in
                            MoviesSection(categorie: section, viewModel: .init()).configureView()
                                .frame(height: 250)
                        }
                        Spacer()
                    }
                    .navigationTitle("What would you like to watch?")
                .navigationBarTitleDisplayMode(.inline)
                }
            }
            .searchable(text: $movieSearch)
        }
    }
}
    

#Preview {
    return HomeScreen()
}

