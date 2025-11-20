//
//  MovieListerView.swift
//  Movielister
//
//  Created by Hilal Kahraman on 18.11.2025.
//

import SwiftUI

struct MovieListerView: View {
    @State private var searchText: String = ""
    @FocusState private var isEditorFocused: Bool
    
    var movies: [MovieItem] {
        searchText
            .components(separatedBy: .newlines)
            .filter { !$0.isEmpty }
            .compactMap { MovieLineParser.parse($0) }
    }
    
    var body: some View {
        
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                Text("Movie Lister")
                    .font(.mainTitle)
                    .foregroundStyle(.titleText)
                Text("Track your movie list")
                    .font(.description)
                    .foregroundStyle(.descriptionText)
                Spacer().frame(height: 16)
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        if !movies.isEmpty {
                            Text("\(movies.count) movies")
                                .font(.smallText)
                                .foregroundStyle(.smallText)
                        }
                        Spacer()
                        Button("Paste") {
                            searchText = UIPasteboard.general.string ?? ""
                        }
                        .frame(height: 24)
                        .padding(.horizontal, 12)
                        .background(.mainOrange)
                        .foregroundStyle(.white)
                        .font(.smallButtonText)
                        .cornerRadius(12)
                        Spacer().frame(width: 16)
                        Button {
                            searchText.removeAll()
                        } label: {
                            Image(.iconTrash)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                    ZStack(alignment: .topLeading) {
                        TextEditor(text: $searchText)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 9)
                            .frame(minHeight: 150, idealHeight: 150)
                            .background(.textviewBackground)
                            .scrollContentBackground(.hidden)
                            .cornerRadius(10)
                            .font(.mainText)
                            .focused($isEditorFocused)
                        
                        if searchText.isEmpty {
                            Text("Add your movie list here..")
                                .foregroundStyle(.secondary)
                                .font(.mainText)
                                .padding(16)
                                .allowsHitTesting(false)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)
                }
                .frame(height: 215)
                .background(Color.white)
                .cornerRadius(20)
                if !movies.isEmpty {
                    let unwatchedMovies = movies.filter { !$0.isWatched }
                    if !unwatchedMovies.isEmpty {
                        Spacer().frame(height: 16)
                        MovieListView(viewModel: .init(
                            image: Image("icon-glasses"),
                            header: "UNWATCHED",
                            movieList: unwatchedMovies
                        ))
                    }
                    let watchedMovies = movies.filter { $0.isWatched }
                    if !watchedMovies.isEmpty {
                        Spacer().frame(height: 16)
                        MovieListView(viewModel: .init(
                            image: Image("icon-checked"),
                            header: "WATCHED",
                            movieList: watchedMovies
                        ))
                    }
                }
            }
            .padding(20)
        }
        .scrollBounceBehavior(.basedOnSize)
        .background(Color.mainBackground)
        .onTapGesture {
            isEditorFocused = false
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button {
                    isEditorFocused = false
                } label: {
                    Image(systemName: "keyboard.chevron.compact.down")
                        .imageScale(.medium)
                }
            }
        }
    }
}

#Preview {
    MovieListerView()
}
