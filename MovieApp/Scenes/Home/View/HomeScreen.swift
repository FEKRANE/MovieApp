//
//  HomeScreen.swift
//  MovieApp
//
//  Created by FEKRANE on 29/11/2023.
//

import SwiftUI

protocol HomeDisplayLogic {
    func displaySection(sections: [MovieCategory])
}

struct HomeScreen: View {
    var interactor: (any HomeBusinessLogic)?
    @State private var movieSearch = ""
    @ObservedObject  var viewModel = HomeModel.ViewModel()
    var body: some View {
        NavigationView {
            ZStack {
                Color(.background)
                    .ignoresSafeArea(.all)
                ScrollView(showsIndicators: false) {
                    VStack {
                        TopRatedCarousel().configureView()
                            .frame(height: 250)
                        ForEach(viewModel.sections, id: \.self) { section in
                            MoviesSection(categorie: section)
                                .frame(height: 200)
                        }
                        Spacer()
                    }
                    .navigationTitle("What would you like to watch?")
                .navigationBarTitleDisplayMode(.inline)
                }
            }  
            .onAppear {
                interactor?.getSections()
            }
            .searchable(text: $movieSearch)
        }
    }
}

extension HomeScreen: HomeDisplayLogic {
    func displaySection(sections: [MovieCategory]) {
        viewModel.sections = sections
    }
    
    
}

#Preview {
    let model = HomeModel.ViewModel()
    model.sections = [
        .upcoming,
        .popular,
        .topRatedMovies
    ]
    return HomeScreen(viewModel: model)
}

