//
//  MovieButtons.swift
//  MovieApp
//
//  Created by digital on 05/06/2023.
//

import SwiftUI

struct MovieButtons: View {
    
    @Binding var isAdded: Bool
    @Binding var isLiked: Bool
    
    var body: some View {
        VStack {
            HStack {
                Button {
                } label: {
                    Text("▶️ Trailer")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
                Button {
                    
                } label: {
                    Text("⬇ Download")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
            }
            
            HStack {
                Button(action: {
                    isAdded.toggle()
                }, label: {
                    Image(systemName: isAdded ? "checkmark.circle.fill" : "plus.circle")
                        .font(.largeTitle)
                })
                Text("Add to my list")
                    .font(.subheadline)
                
                Button(action: {
                    isLiked.toggle()
                }) {
                    Image(systemName: isLiked ? "heart.fill" : "heart")
                        .foregroundColor(isLiked ? .red : .gray)
                }
                Text("Like")
            }
            .padding(.leading, 90)
        }
        .frame(maxWidth: .infinity)
    }
}



