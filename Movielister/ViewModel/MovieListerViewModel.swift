//
//  MovieListerViewModel.swift
//  Movielister
//
//  Created by Hilal Kahraman on 21.11.2025.
//

import SwiftUI

@Observable
class MovieListerViewModel {
    var searchText: String = ""
    
    var movies: [MovieItem] {
        searchText
            .components(separatedBy: .newlines)
            .filter { !$0.isEmpty }
            .compactMap { MovieLineParser.parse($0) }
    }
    
    var unwatchedMovies: [MovieItem] {
        movies.filter { !$0.isWatched }
    }
    
    var watchedMovies: [MovieItem] {
        movies.filter { $0.isWatched }
    }
    
    var movieCount: Int {
        movies.count
    }
    
    func pasteFromClipboard() {
        searchText = UIPasteboard.general.string ?? ""
    }
    
    func clearText() {
        searchText.removeAll()
    }
    
    func searchMovie(with movie: MovieItem) {
        let query = movie.title.addingPercentEncoding(
            withAllowedCharacters: .urlQueryAllowed
        ) ?? ""
        let googleUrlString = "https://www.google.com/search?q=\(query)+izle"
        if let url = URL(string: googleUrlString) {
            UIApplication.shared.open(url)
        }
    }
}
