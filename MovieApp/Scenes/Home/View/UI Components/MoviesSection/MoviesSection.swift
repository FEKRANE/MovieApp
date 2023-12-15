//
//  MoviesSection.swift
//  MovieApp
//
//  Created by FEKRANE on 29/11/2023.
//

import Foundation
import SwiftUI

struct MoviesSection: View {
    let title: String
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .font(.title2)
                Spacer()
                Button(action: {
                    //TODO: Add action
                }, label: {
                    Text("See more")
                        .font(.caption)
                        .foregroundStyle(Color(.red))
                        .padding(.horizontal,8)
                        .padding(.vertical,3)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color(.red), lineWidth: 1)
                        )
                })
            }
            
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(0..<10){ _ in
                        MovieCell(selection: {})
                    }
                }
            }
        }.padding()
    }
}


#Preview {
    MoviesSection(title: "Upcoming movies")
        .frame(height: 220)
}
