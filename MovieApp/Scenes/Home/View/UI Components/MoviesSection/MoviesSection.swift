//
//  MoviesSection.swift
//  MovieApp
//
//  Created by FEKRANE on 29/11/2023.
//

import Foundation
import SwiftUI

struct MoviesSection: View {
    let categorie: MovieCategory
    @State private var isActive: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Text(categorie.title)
                    .font(.title2)
                Spacer()
                Button(action: {
                    self.isActive = true
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
                .background(
                    NavigationLink(
                        destination: MovieListScreen(
                            movieCategory: categorie
                        ).configureView(),
                        isActive: $isActive,
                        label: {
                            EmptyView()
                        }
                    )
                )
            }
            
            ScrollView(.horizontal,showsIndicators: false) {
                LazyHStack {
                    ForEach(0..<10){ _ in
                        MovieCell(selection: {}, imageUrl: "")
                    }
                }
            }
        }.padding()
    }
}


#Preview {
    MoviesSection(categorie: .topRatedMovies)
        .frame(height: 220)
}
