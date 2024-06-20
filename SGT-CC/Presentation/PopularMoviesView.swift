//
//  PopularMoviesView.swift
//  SGT-CC
//
//  Created by AhmadShraby on 6/19/24.
//

import SwiftUI
import Application

struct PopularMoviesView: View {
    @Environment(\.appDIContainer) private var container: AppDIContainer
    @ObservedObject private var viewModel: PopularMoviesViewModel

    init(viewModel: PopularMoviesViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            List(viewModel.movies) { movie in
//                NavigationLink(destination: MovieDetailView(movie: movie)) {
                    HStack {
                        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w200\(movie.posterPath ?? "")"))
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100)
                        VStack(alignment: .leading) {
                            Text(movie.title ?? "Title")
                                .font(.headline)
                                .multilineTextAlignment(.center)
                                .lineLimit(2)
                            Text(movie.releaseDate ?? "Date")
                                .font(.subheadline)
                        }
                    }
//                }
            }
            .navigationTitle("Popular Movies")
            .onAppear {
                viewModel.fetchPopularMovies()
            }
        }
    }
}

//#Preview {
//    PopularMoviesView(viewModel: <#PopularMoviesViewModel#>)
//}
