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
    
    init(selection: @escaping () -> Void) {
        self.selection = selection
    }
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w400/7bWxAsNPv9CXHOhZbJVlj2KxgfP.jpg")) { poster in
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
    MovieCell(selection: {})
        .padding()
        .frame(height: 200)
}
