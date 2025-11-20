//
//  MovieItem.swift
//  Movielister
//
//  Created by Hilal Kahraman on 20.11.2025.
//

import Foundation

struct MovieItem {
    let id = UUID()
    let title: String
    let note: String?
    let isWatched: Bool
}
