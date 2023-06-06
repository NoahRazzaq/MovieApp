//
//  MovieDetailsViewModel.swift
//  MovieApp
//
//  Created by digital on 18/04/2023.
//

import Foundation
import SwiftUI

@MainActor
class MovieDetailsViewModel: ObservableObject {


    
    @Published var movie: MovieDetail?


    func movieDetails(for movieID: Int) async {
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieID)?api_key=\(MovieDiscoverViewModel.apiKey)&language=en-US")!
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let movieDetail = try JSONDecoder().decode(MovieDetail.self, from: data)
            DispatchQueue.main.async {
                        self.movie = movieDetail
                    }
        } catch {
            print(error.localizedDescription)
        }
    }

    
}
