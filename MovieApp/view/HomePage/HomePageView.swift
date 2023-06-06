//
//  HomePageView.swift
//  MovieApp
//
//  Created by Noah Razzaq on 20/5/2023.
//

import SwiftUI
import CoreLocation
import MapKit


struct HomePageView: View {

    @StateObject var viewModel = MovieDiscoverViewModel()
    
    @State private var showMapView = false
    @StateObject private var locationManager = LocationManager()
    
    @State private var selectedMovie: Movie? = nil
    @State private var isMapViewPresented = false


    var body: some View {
        NavigationStack {
            Text("Netflix")
                .font(.title)
                .foregroundColor(.red)
                .fontWeight(.bold)

            ScrollView {
                    if viewModel.popular.isEmpty {
                        Text("No movie found")
                    } else {
                        VStack {
                            Text("Genres")
                            .font(.title)
                            .fontWeight(.heavy)
                            .padding(.top)

                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 10) {
                                        ForEach(viewModel.genres, id: \.self) { genre in
                                            NavigationLink {
                                                MoviesByGenreView(genre: genre)
                                            } label: {
                                                GenreButton(genre: genre.name)
                                            }
    
                                                }
                                            }
                                            .padding(.horizontal)
                                        }
                                    }
                        HStack {
                            Text("Popular")
                                .font(.title)
                                .fontWeight(.heavy)
                            Spacer()
                        }
                        .padding(.horizontal)
                
                            
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(viewModel.popular) { popularItem in
                                    Button(action: {
                                        selectedMovie = popularItem
                                    }) {
                                        TrendingCard(trendingItem: popularItem)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                        .sheet(item: $selectedMovie) { movie in
                            MovieDetailView(movie: movie)
                        }

                        
                        Spacer(minLength: 52)
                        
                        VStack {
                            HStack {
                                Image(systemName: "mappin.circle.fill")
                                    .font(.largeTitle)
                                    .foregroundColor(.red)
                                            
                                Text("Find movie theaters around your location")
                                    .font(.headline)
                                }
                                .padding()
                            
                            Button(action: {
                                           showMapView = true
                                       }) {
                                           Map(coordinateRegion: .constant(regionForLocation(locationManager.coordinate)))
                                               .frame(height: 200)
                                               .cornerRadius(10)
                                       }
                                       .padding()
                            
                        }
                        .sheet(isPresented: $showMapView) {
                            MapTestView(coordinate: CLLocationCoordinate2D(latitude: 45.899247, longitude: 6.129384 ))
                
                        }
                    }
            }
        }
    
        .onAppear {
            viewModel.loadPopular()
            viewModel.loadGenres()
        }
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}


