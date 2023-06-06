//
//  MovieList.swift
//  MovieApp
//
//  Created by Noah Razzaq on 20/5/2023.
//

import Foundation

struct MovieList: Decodable {
    let page: Int
    let results: [Movie]
    let total_pages: Int
}


