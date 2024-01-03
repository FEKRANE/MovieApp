//
//  HomeScreen.swift
//  MovieApp
//
//  Created by FEKRANE on 29/11/2023.
//

import SwiftUI

protocol HomeDisplayLogic {
    func displaySection(sections: [String])
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
                        TopRatedCarousel()
                            .frame(height: 250)
                        ForEach(viewModel.sections, id: \.self) { title in
                            MoviesSection(title: title)
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
    func displaySection(sections: [String]) {
        viewModel.sections = sections
    }
    
    
}

#Preview {
    let model = HomeModel.ViewModel()
    model.sections = [
        "Upcomming Movies",
        "Popular Movies",
        "Latest Tv Shows"
    ]
    return HomeScreen(viewModel: model)
}

