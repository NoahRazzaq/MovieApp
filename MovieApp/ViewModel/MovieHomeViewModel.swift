//
//  MovieDiscoverViewModel.swift
//  MovieApp
//
//  Created by Noah Razzaq on 20/5/2023.
//

import Foundation

@MainActor
class MovieHomeViewModel: ObservableObject {

    @Published var popular: [Movie] = []
    @Published var genres: [Genre] = []
    @Published var movies: [Movie] = []
    @Published var searchResults: [Movie] = []


    static let apiKey = "ddafcae466ac0e875e889ee257681ccb"
    

    func loadPopular() {
        Task {
            let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(MovieHomeViewModel.apiKey)")!
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
            let url = URL(string: "https://api.themoviedb.org/3/genre/movie/list?api_key=\(MovieHomeViewModel.apiKey)")!
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
            let url = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=\(MovieHomeViewModel.apiKey)&language=en-US&page=1&with_genres=\(genreId)")!
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
    
    func searchMovies(term: String) {
            Task {
                let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=\(MovieHomeViewModel.apiKey)&language=en-US&page=1&include_adult=false&query=\(term)".addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!)!
                do {
                    let (data, _) = try await URLSession.shared.data(from: url)
                    let trendingResults = try JSONDecoder().decode(MovieList.self, from: data)
                    searchResults = trendingResults.results
                } catch {
                    print(error.localizedDescription)
                }
            }
        }





}
