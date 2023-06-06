//
//  Maap.swift
//  MovieApp
//
//  Created by digital on 06/06/2023.
//

import Foundation
import MapKit

private var locationManager = LocationManager()


class Map {
    
    class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
        private let locationManager = CLLocationManager()
        
        @Published var coordinate = CLLocationCoordinate2D()
        
        override init() {
            super.init()
            
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        }
        
        func startUpdatingLocation() {
            locationManager.requestWhenInUseAuthorization()
            
            if CLLocationManager.locationServicesEnabled() {
                locationManager.startUpdatingLocation()
            }
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let location = locations.last else { return }
            
            coordinate = location.coordinate
        }
    }
    
}
