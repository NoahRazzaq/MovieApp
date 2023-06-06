//
//  MoviesByGenre.swift
//  MovieApp
//
//  Created by digital on 22/05/2023.
//

import Foundation
import SwiftUI

struct MoviesByGenreView: View {
    
    let genre: Genre
    @StateObject var viewModel = MovieDiscoverViewModel()
    @State private var movies: [Movie] = []

    var body: some View {
        
        NavigationStack {
            Text(genre.name)
                .font(.title)
                .fontWeight(.bold)
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    ForEach(movies) { movie in
                        NavigationLink(destination: MovieDetailView(movie: movie)) {
                            MovieCard(movie: movie)
                        }
                    }
                }
                .padding()
            }

        }
        .onAppear {
            viewModel.loadMoviesByGenre(for: genre.id) { fetchedMovies in
                           movies = fetchedMovies
            }
        }
    }
}


struct MovieByGenre_Previews: PreviewProvider {
    static var previews: some View {
        MoviesByGenreView(genre: .preview)
    }
}
