//
//  FaceId.swift
//  MovieApp
//
//  Created by digital on 05/06/2023.
//

import SwiftUI
import LocalAuthentication

struct FaceIDView: View {
    @State private var unlocked = false
    @State private var authenticationResult = ""
    private let faceIDAuthenticator = FaceIDAuthenticator()

    
    var body: some View {
        NavigationView {
            VStack {
                if unlocked {
                    HomePageView()
                } else {
                    VStack {
                        Text("Face ID for Authentication")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding()
                        
                        Button(action: {
                            authenticateWithFaceID() }) {
                                Image(systemName: "faceid")
                                    .font(.system(size: 120))
                            }
                        }
                    .padding(.bottom)
                    
                    Text("Press on the Face ID button to access to Netflix")
                        .font(.headline)
                        .foregroundColor(.gray)
                }
            }
        }
    }
    
    func authenticateWithFaceID() {
           faceIDAuthenticator.authenticateWithFaceID { success, result in
               if success {
                   authenticationResult = result
                   unlocked = true
               } else {
                   authenticationResult = result
               }
           }
       }
    }



struct FaceId_Previews: PreviewProvider {
    static var previews: some View {
        FaceIDView()
    }
}
