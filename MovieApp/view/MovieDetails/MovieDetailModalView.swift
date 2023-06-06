//
//  MovieDetailModalView.swift
//  MovieApp
//
//  Created by digital on 06/06/2023.
//

import Foundation
import SwiftUI

struct MovieDetailModalView: View {

    @StateObject var model = MovieDetailsViewModel()
    let movie: Movie
    let headerHeight: CGFloat = 300
    
    @State private var isAdded = false
    @State private var isLiked = false

    var body: some View {
            ZStack {
                
                GeometryReader { geo in
                    VStack {
                        AsyncImage(url: movie.backdropURL) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: geo.size.width, maxHeight: headerHeight)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                        } placeholder: {
                            ProgressView()
                        }
                    }
                }
                .ignoresSafeArea()
                
                ScrollView {
                    
                    VStack {
                        MovieHeader(movie: movie)
                        Spacer()
                        MovieOverview(movie: movie)
                        Spacer()
                        MovieButtons(isAdded: $isAdded, isLiked: $isLiked)
                        Spacer(minLength: 300)
                    }
                    .padding(.horizontal)
                }
                .offset(y: headerHeight)
            }
            .task {
                await model.movieDetails(for: movie.id)
            }
    }
}






struct MovieDetailModalView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailModalView( movie: .preview)
    }
}
