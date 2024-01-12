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
    let imageUrl: URL
    
    init(selection: @escaping () -> (), imageUrl: URL) {
       self.selection = selection
       self.imageUrl = imageUrl
   }
    
    var body: some View {
        VStack {
            AsyncImage(url: imageUrl) { poster in
                poster
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            } placeholder: {
                ProgressView()
            }
            
            Text("Evil Dead Rise")
                .font(.headline)
        }
    }
}


#Preview {
    MovieCell(selection: {}, imageUrl: URL(string: "https://image.tmdb.org/t/p/w400/7bWxAsNPv9CXHOhZbJVlj2KxgfP.jpg")!)
        .padding()
        .frame(height: 200)
}
