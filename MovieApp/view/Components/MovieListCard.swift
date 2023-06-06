//
//  TrendingCard.swift
//  MovieApp
//
//  Created by Noah Razzaq on 20/5/2023.
//

import Foundation
import SwiftUI

struct MovieListCard: View {

    let movie: Movie

    var body: some View {
        ZStack(alignment: .bottom) {
            AsyncImage(url: movie.backdropURL) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 340, height: 240)
            } placeholder: {
                Rectangle().fill(Color(red:61/255,green:61/255,blue:88/255))
                        .frame(width: 340, height: 240)
            }

            VStack {
                HStack {
                    Text(movie.title)
                        .foregroundColor(.white)
                        .fontWeight(.heavy)
                }
            }
            .padding()
        }
        .cornerRadius(10)
    }
}
