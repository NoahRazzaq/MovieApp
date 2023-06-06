//
//  GenreButton.swift
//  MovieApp
//
//  Created by digital on 23/05/2023.
//

import Foundation
import SwiftUI

struct GenreButton: View {
    let genre: String
    
    var body: some View {
        Text(genre)
            .font(.caption)
            .foregroundColor(.white)
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(Color.blue)
            .cornerRadius(10)
    }
}

