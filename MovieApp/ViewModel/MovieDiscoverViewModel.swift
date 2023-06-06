//
//  MovieDiscoverViewModel.swift
//  MovieApp
//
//  Created by Noah Razzaq on 20/5/2023.
//

import Foundation

@MainActor
class MovieDiscoverViewModel: ObservableObject {

    @Published var popular: [Movie] = []
    @Published var genres: [Genre] = []
    @Published var movies: [Movie] = []


    static let apiKey = "9a8f7a5168ace33d2334ba1fe14a83fb"
    

    func loadPopular() {
        Task {
            let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(MovieDiscoverViewModel.apiKey)&")!
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let movieList = try JSONDecoder().decode(MovieList.self, from: data)
                popular = movieList.results
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func loadGenres() {
        Task {
            let url = URL(string: "https://api.themoviedb.org/3/genre/movie/list?api_key=\(MovieDiscoverViewModel.apiKey)")!
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let genreResponse = try JSONDecoder().decode(GenreModel.self, from: data)
                genres = genreResponse.genres
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    
    func loadMoviesByGenre(for genreId: Int, completion: @escaping ([Movie]) -> Void) {
        Task {
            let url = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=\(MovieDiscoverViewModel.apiKey)&language=en-US&page=1&with_genres=\(genreId)")!
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let moviesResponse = try JSONDecoder().decode(MovieByGenre.self, from: data)
                completion(moviesResponse.results)
            } catch {
                print(error.localizedDescription)
                completion([])
            }
        }
    }





}
