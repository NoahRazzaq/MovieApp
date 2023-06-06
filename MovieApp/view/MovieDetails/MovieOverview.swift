//
//  MovieOverview.swift
//  MovieApp
//
//  Created by digital on 05/06/2023.
//

import SwiftUI

struct MovieOverview: View {
    let movie: Movie
    var body: some View {
        
        Text(movie.overview)
            .font(.body)
            .lineLimit(nil)
            .padding(.bottom, 20)
       
    }
}


