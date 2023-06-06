//
//  Movie.swift
//  MovieApp
//
//  Created by digital on 04/04/2023.
//

import Foundation

struct Movie: Identifiable, Decodable{
    let id: Int
    let poster_path: String?
    let title: String
    let overview: String
    let vote_average: Float
    let release_date: String
    let adult: Bool
    let backdrop_path: String?

    var backdropURL: URL? {
        let baseURL = URL(string: "https://image.tmdb.org/t/p/original")
        return baseURL?.appending(path: backdrop_path ?? "")
    }

    var posterThumbnail: URL? {
        let baseURL = URL(string: "https://image.tmdb.org/t/p/w100")
        return baseURL?.appending(path: poster_path ?? "")
    }

    var poster: URL? {
        let baseURL = URL(string: "https://image.tmdb.org/t/p/w500")
        return baseURL?.appending(path: poster_path ?? "")
    }

    static var preview: Movie {
        return Movie(
                     id: 1,
                     poster_path: "/bp5PqLa06QA1LsELA1SsKZ008H7.jpg",
                     title: "Spiderman",
                     overview: "After being bitten by a genetically altered spider at Oscorp, nerdy but endearing high school student Peter Parker is endowed with amazing powers to become the superhero known as Spider-Man.",
                     vote_average: 100,
                     release_date: "2020",
                     adult: true,
                     backdrop_path: "/jHxCeXnSchAuwHnmVatTgqMYdX8.jpg")
    }
}

struct MovieDetail: Identifiable,Decodable {
    let id: Int
    let poster_path: String?
    let title: String
    let overview: String
    let vote_average: Float
    let release_date: String
    let adult: Bool
    let backdrop_path: String?
  
    
    
    static var preview: MovieDetail {
        return MovieDetail(
                     id: 1,
                     poster_path: "https://image.tmdb.org/t/p/w300",
                     title: "Spiderman",
                     overview: "Great moviiiiieeeeee",
                     vote_average: 100,
                     release_date: "2020",
                     adult: true,
                     backdrop_path: "https://image.tmdb.org/t/p/w300")
    }
}
