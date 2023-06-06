//
//  Genre.swift
//  MovieApp
//
//  Created by digital on 22/05/2023.
//

import Foundation

struct Genre: Decodable, Hashable {
    let id: Int
    let name: String
    
    
    static var preview: Genre {
        return Genre(   id: 1,
                        name: "Fantastic")
    }
}

struct GenreModel: Decodable {
    let genres : [Genre]
}


