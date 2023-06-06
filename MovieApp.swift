//
//  MovieLookupApp.swift
//  MovieLookup
//
//  Created by digital on 04/04/2023.
//

import SwiftUI

@main
struct MovieApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                SplashView()
                    .tabItem {
                        Image(systemName: "house.fill")
                    }
                    Text("Play")
                        .tabItem {
                            Image(systemName: "play.rectangle.on.rectangle.fill")
                            }
                    Text("Download")
                        .tabItem {
                        Image(systemName: "square.and.arrow.down")
                                        }
            }
        }
    }
}
