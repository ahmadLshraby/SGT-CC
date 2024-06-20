//
//  MovieRowView.swift
//  SGT-CC
//
//  Created by AhmadShraby on 6/20/24.
//

import SwiftUI
import Core

struct MovieRowView: View {
    let movie: MoviesResult

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w200\(movie.posterPath ?? "")")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 150)
                    .clipped()
            } placeholder: {
                ProgressView()
                    .frame(width: 100, height: 150)
            }
            .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 10) {
                Text(movie.title ?? "Unknown Title")
                    .font(.headline)
                Text(movie.releaseDate ?? "Unknown Date")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text(movie.overview ?? "No overview available.")
                    .font(.body)
                    .lineLimit(3)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .cornerRadius(15)
        .shadow(radius: 5)
    }
}

#Preview {
    MovieRowView(movie: MoviesResult(id: 0))
}
