//
//  MovieTheaters.swift
//  MovieApp
//
//  Created by digital on 05/06/2023.
//

import Foundation
import MapKit


struct MovieTheater: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}
