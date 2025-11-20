//
//  MovieItemView.swift
//  Movielister
//
//  Created by Hilal Kahraman on 20.11.2025.
//

import SwiftUI

struct MovieItemView: View {
    let movieItem: MovieItem
    let onSearchTapped: () -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(movieItem.title)
                    .font(.titleText)
                    .foregroundStyle(Color.itemText)
                if let note = movieItem.note {
                    Text(note)
                        .font(.smallText)
                        .foregroundStyle(Color.itemText.opacity(0.8))
                }
            }
            Spacer()
            Button(action: onSearchTapped) {
                Image("icon-search")
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 5)
        .frame(height: 44)
        .background(movieItem.isWatched ? Color.mainWhite : Color.mainPurple)
        .cornerRadius(44)
    }
}

#Preview {
    MovieItemView(movieItem: MovieItem(title: "Inception", note: "Christopher Nolan", isWatched: true), onSearchTapped: {})
    MovieItemView(movieItem: MovieItem(title: "The Dark Knight", note: nil, isWatched: false), onSearchTapped: {})
}
