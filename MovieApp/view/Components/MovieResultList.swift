//
//  MovieResultList.swift
//  MovieApp
//
//  Created by digital on 06/06/2023.
//

import SwiftUI

struct MovieResultList: View {
    var movies: [Movie]
    @State private var selectedMovie: Movie? = nil
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(movies) { item in
                    Button(action: {
                        selectedMovie = item
                    }) {
                        HStack {
                            AsyncImage(url: item.poster) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 80, height: 120)
                            } placeholder: {
                                ProgressView()
                                    .frame(width: 80, height: 120)
                            }
                            .clipped()
                            .cornerRadius(10)

                            Text(item.title)
                                .font(.headline)
                                .padding(.leading)

                            Spacer()
                        }
                        .padding()
                        .padding(.horizontal)
                    }
                }
            }
            .sheet(item: $selectedMovie) { movie in
                MovieDetailView(movie: movie)
            }
        }
    }
}


