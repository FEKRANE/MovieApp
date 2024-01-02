//
//  MovieCell.swift
//  MovieApp
//
//  Created by FEKRANE on 29/11/2023.
//

import Foundation
import SwiftUI

struct MovieCell: View {
        
    let selection: () -> ()
    let imageUrl: String
    
    init(selection: @escaping () -> (), imageUrl: String) {
       self.selection = selection
       self.imageUrl = imageUrl
   }
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: imageUrl)) { poster in
                poster
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            } placeholder: {
                ProgressView()
            }
            
            Text("Evil Dead Rise")
                .font(.headline)
        }
    }
}


#Preview {
    MovieCell(selection: {}, imageUrl: "https://image.tmdb.org/t/p/w400/7bWxAsNPv9CXHOhZbJVlj2KxgfP.jpg")
        .padding()
        .frame(height: 200)
}
