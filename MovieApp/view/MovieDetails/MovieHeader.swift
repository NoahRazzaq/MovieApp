//
//  MovieHeader.swift
//  MovieApp
//
//  Created by digital on 05/06/2023.
//

import SwiftUI

struct MovieHeader: View {
    let movie: Movie
        
        var body: some View {
            
                
                VStack(alignment: .trailing, spacing: 10){
                    Text(movie.title)
                        .font(.title)
                        .fontWeight(.bold)
                }
            
            HStack(spacing: 10) {
                AsyncImage(url: movie.poster) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 225)
                        .cornerRadius(10)
                } placeholder: {
                    ProgressView()
                }
            }
            
            
            HStack {
                Text("Recommanded by \(String(format: "%.0f%%", movie.vote_average * 10))")
                    .foregroundColor(.green)
                
                Text("\(String(movie.release_date.prefix(4)))")
                    .font(.headline)
                    .foregroundColor(.gray)
                
                if movie.adult {
                    Text("+18")
                        .shadow(color: .gray, radius: 5 )
                        .border(.black, width: 1)
                } else {
                    Text("+3")
                        .shadow(color: .gray, radius: 5 )
                        .border(.black, width: 1)
                }
            }
            .padding()
        }
}


