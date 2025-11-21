//
//  MovieListerView.swift
//  Movielister
//
//  Created by Hilal Kahraman on 18.11.2025.
//

import SwiftUI

struct MovieListerView: View {
    @State private var viewModel = MovieListerViewModel()
    @FocusState private var isEditorFocused: Bool
    
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
                        if !viewModel.movies.isEmpty {
                            Text("\(viewModel.movieCount) movies")
                                .font(.smallText)
                                .foregroundStyle(.smallText)
                        }
                        Spacer()
                        Button("Paste") {
                            viewModel.pasteFromClipboard()
                        }
                        .frame(height: 24)
                        .padding(.horizontal, 12)
                        .background(.mainOrange)
                        .foregroundStyle(.white)
                        .font(.smallButtonText)
                        .cornerRadius(12)
                        Spacer().frame(width: 16)
                        Button {
                            viewModel.clearText()
                        } label: {
                            Image(.iconTrash)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                    ZStack(alignment: .topLeading) {
                        TextEditor(text: $viewModel.searchText)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 9)
                            .frame(minHeight: 150, idealHeight: 150)
                            .background(.textviewBackground)
                            .scrollContentBackground(.hidden)
                            .cornerRadius(10)
                            .font(.mainText)
                            .foregroundStyle(.black)
                            .focused($isEditorFocused)
                        
                        if viewModel.searchText.isEmpty {
                            Text("Add your movie list here..")
                                .foregroundStyle(.gray)
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
                if !viewModel.movies.isEmpty {
                    let unwatchedMovies = viewModel.unwatchedMovies
                    if !unwatchedMovies.isEmpty {
                        Spacer().frame(height: 16)
                        MovieListView(viewModel: .init(
                            image: Image("icon-glasses"),
                            header: "UNWATCHED",
                            movieList: unwatchedMovies
                        ), onSearchMovie: viewModel.searchMovie)
                    }
                    let watchedMovies = viewModel.watchedMovies
                    if !watchedMovies.isEmpty {
                        Spacer().frame(height: 16)
                        MovieListView(viewModel: .init(
                            image: Image("icon-checked"),
                            header: "WATCHED",
                            movieList: watchedMovies
                        ), onSearchMovie: viewModel.searchMovie)
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
