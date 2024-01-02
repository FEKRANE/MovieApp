//
//  HomeModel.swift
//  MovieApp
//
//  Created by FEKRANE on 29/12/2023.
//

import Foundation

enum HomeModel {
    class ViewModel: ObservableObject {
        @Published var sections: [String] = []
    }
}
