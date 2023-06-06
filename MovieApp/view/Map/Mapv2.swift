//
//  test.swift
//  MovieApp
//
//  Created by digital on 05/06/2023.
//

import Foundation
import SwiftUI
import MapKit

struct MapTestView: UIViewRepresentable {
    var coordinate: CLLocationCoordinate2D
    @State private var movieTheaters: [MovieTheater] = []

    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView(frame: .zero)
        mapView.delegate = context.coordinator
        return mapView
    }
    
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        let region = regionForLocation(coordinate)
        uiView.setRegion(region, animated: true)
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "cinemas"
        request.region = region
        
        let search = MKLocalSearch(request: request)
        search.start { response, error in
            guard let response = response, error == nil else {
                print("Error searching for cinemas: \(error?.localizedDescription ?? "")")
                return
            }
            
            self.movieTheaters = response.mapItems.map { item in
                MovieTheater(name: item.name ?? "", coordinate: item.placemark.coordinate)
            }
            
            for theater in self.movieTheaters {
                let annotation = MKPointAnnotation()
                annotation.coordinate = theater.coordinate
                annotation.title = theater.name
                uiView.addAnnotation(annotation)
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapTestView
        
        init(_ parent: MapTestView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            if let theater = parent.movieTheaters.first(where: { $0.name == view.annotation?.title }) {
                print("Selected movie theater: \(theater.name)")
            }
        }
    }
    
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

struct MapTestView_Previews: PreviewProvider {
    static var previews: some View {
        MapTestView(coordinate: CLLocationCoordinate2D(latitude: 45.907841, longitude: 6.129384))
    }
}


public func regionForLocation(_ coordinate: CLLocationCoordinate2D) -> MKCoordinateRegion {

    let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    return MKCoordinateRegion(center: coordinate, span: span)
}
