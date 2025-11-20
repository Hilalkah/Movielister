//
//  MovieListView.swift
//  Movielister
//
//  Created by Hilal Kahraman on 20.11.2025.
//

import SwiftUI

struct MovieListViewModel {
    var image: Image
    var header: String
    var movieList: [MovieItem]
}

struct MovieListView: View {
    var viewModel: MovieListViewModel
    
    @State private var isCollapsed = false
    
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack {
                viewModel.image
                Text(viewModel.header)
                    .font(.smallTitleText)
                    .foregroundStyle(Color.smallText)
                Text(viewModel.movieList.count.description)
                    .font(.smallNumberText)
                    .frame(width: 12, height: 12)
                    .background(Color.mainWhite)
                    .foregroundStyle(Color.smallText)
                    .cornerRadius(12)
                Spacer()
                Button {
                    isCollapsed.toggle()
                } label: {
                    Image("icon-arrow")
                        .rotationEffect(isCollapsed ? .radians(.pi) : .zero)
                }
            }
            .frame(height: 24)
            .padding(.horizontal, 16)
            .padding(.top, 16)
            .padding(.bottom, !isCollapsed ? 8 : 0)
            if !isCollapsed {
                ForEach(viewModel.movieList) { movieItem in
                    MovieItemView(movieItem: movieItem)
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 16)
        .background(Color.white)
        .cornerRadius(20)
    }
}

#Preview {
    MovieListView(viewModel: .init(
        image: Image("icon-glasses"),
        header: "UNWATCHED",
        movieList: [
            MovieItem(title: "Inception", note: "Christopher Nolan", isWatched: false),
            MovieItem(title: "The Dark Knight", note: nil, isWatched: false)
        ]
    ))
    
    MovieListView(viewModel: .init(
        image: Image("icon-checked"),
        header: "WATCHED",
        movieList: [
            MovieItem(title: "Here", note: nil, isWatched: true)
        ]
    ))
}
