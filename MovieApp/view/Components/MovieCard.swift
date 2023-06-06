//
//  MovieCard.swift
//  MovieLookup
//
//  Created by digital on 23/05/2023.
//

import Foundation
import SwiftUI

struct MovieCard: View {
    let movie: Movie
    
    var body: some View {
        VStack {
            if let posterPath = movie.poster_path {
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 120, height: 190)
                            .cornerRadius(10)
                    case .failure:
                        Text("Image invalid")
                            .bold()
                            .font(.title)
                            .multilineTextAlignment(.center)
                    case .empty:
                        ProgressView()
                    @unknown default:
                        EmptyView()
                    }
                }
            } else {
                Text("Image invalid")
                    .bold()
                    .font(.title)
                    .multilineTextAlignment(.center)
            }
        }
    }
}

