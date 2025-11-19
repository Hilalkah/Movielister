//
//  MovieListerView.swift
//  Movielister
//
//  Created by Hilal Kahraman on 18.11.2025.
//

import SwiftUI

struct MovieListerView: View {
    @State private var searchText: String = ""
    
    var body: some View {
        
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
                    Text("")
                        .font(.smallText)
                    Spacer()
                    Button("Paste") {
                        // TODO: Add paste action
                    }
                    .frame(height: 24)
                    .padding(.horizontal, 12)
                    .background(.mainOrange)
                    .foregroundStyle(.white)
                    .font(.smallButtonText)
                    .cornerRadius(12)
                    Spacer().frame(width: 16)
                    Button {
                        // TODO: Add delete action
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
            Spacer()
        }
        .padding(20)
        .background(Color.mainBackground)
    }
}

#Preview {
    MovieListerView()
}
