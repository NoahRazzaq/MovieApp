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
    @StateObject var homeViewModel = MovieHomeViewModel()
    @State private var showMapView = false
    @StateObject private var locationManager = LocationManager()
    @State private var selectedMovie: Movie? = nil
    @State private var isMapViewPresented = false
    @State var searchText = ""

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("Netflix")
                        .font(.title)
                        .foregroundColor(.red)
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding(.horizontal)

                if searchText.isEmpty {
                    if homeViewModel.popular.isEmpty {
                        Text("No movie found")
                    } else {
                        ScrollView {
                            VStack {
                            Text("Genres")
                                .font(.title)
                                .fontWeight(.heavy)
                                .padding(.top)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 10) {
                                    ForEach(homeViewModel.genres, id: \.self) { genre in
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
                                    ForEach(homeViewModel.popular) { popularItem in
                                        Button(action: {
                                            selectedMovie = popularItem
                                        }) {
                                            MovieListCard(movie: popularItem)
                                        }
                                    }
                                }
                                .padding(.horizontal)
                            }
                            .sheet(item: $selectedMovie) { movie in
                                MovieDetailView(movie: movie)
                            }
                            VStack {
                                HStack {
                                    Image(systemName: "mappin.circle.fill")
                                        .font(.largeTitle)
                                        .foregroundColor(.red)
                                    Text("Find movie theaters around you")
                                        .font(.headline)
                                        .padding(.horizontal)
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
                                MapTestView(coordinate: CLLocationCoordinate2D(latitude: 45.899247, longitude: 6.129384))
                            }
                            Spacer(minLength: 40)
                        }
                    }
                } else {
                    ScrollView {
                        MovieResultList(movies: homeViewModel.searchResults )
                    }
                }
            }
        }
        .searchable(text: $searchText)
        .onAppear {
            homeViewModel.loadPopular()
            homeViewModel.loadGenres()
        }
        .onChange(of: searchText) { newValue in
            if newValue.count > 2 {
                homeViewModel.search(term: newValue)
            }
        }
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}


