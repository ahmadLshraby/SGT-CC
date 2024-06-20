//
//  MovieDetailView.swift
//  SGT-CC
//
//  Created by AhmadShraby on 6/20/24.
//

import SwiftUI
import Application
import Core

struct MovieDetailView: View {
    @Environment(\.appDIContainer) private var container: AppDIContainer
    @ObservedObject private var viewModel: MovieDetailsViewModel
    @Environment(\.presentationMode) var presentationMode
    
    init(viewModel: MovieDetailsViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            if let details = viewModel.movieDetails {
                ScrollView {
                    VStack(spacing: 0) {
                        StrechyHeaderView(imagePath: details.backdropPath)
                        
                        VStack(alignment: .leading, spacing: 20) {
                            VStack(spacing: 2) {
                                Text(details.title ?? "")
                                    .font(.largeTitle)
                                    .fontWeight(.heavy)
                                    .padding(.top, 20)
                                    .padding(.horizontal)
                                Divider().padding(.horizontal)
                            }
                            .padding(.horizontal)
                            
                            VStack(spacing: 0) {
                                if let adult = details.adult, adult {
                                    HStack {
                                        Spacer()
                                        Text("18+ Content")
                                            .font(.headline)
                                            .foregroundColor(.red)
                                    }
                                }
                                
                                HStack {
                                    Text("Release Date:")
                                        .font(.headline)
                                        .foregroundColor(.secondary)
                                    Text(details.releaseDate ?? "")
                                        .font(.subheadline)
                                    Spacer()
                                }
                            }
                            .padding(.horizontal)
                            
                            HStack {
                                Text("Rating:")
                                    .font(.headline)
                                    .foregroundColor(.secondary)
                                Text(String(format: "%.1f", details.voteAverage ?? 0))
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                Text("(\(details.voteCount ?? 0) votes)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            .padding(.horizontal)
                            
                            if let genres = details.genres {
                                VStack(alignment: .leading) {
                                    Text("Genres:")
                                        .font(.headline)
                                        .foregroundColor(.secondary)
                                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                                        ForEach(genres, id: \.id) { genre in
                                            if let name = genre.name {
                                                Text(name)
                                                    .font(.subheadline)
                                                    .lineLimit(1)
                                                    .padding(.horizontal, 10)
                                                    .padding(.vertical, 5)
                                                    .background(Color.blue.opacity(0.1))
                                                    .clipShape(Capsule())
                                            }
                                        }
                                    }
                                }
                                .padding(.horizontal)
                            }
                            
                            if let originalLanguage = details.originalLanguage {
                                HStack {
                                    Text("Original Language:")
                                        .font(.headline)
                                        .foregroundColor(.secondary)
                                    Text(originalLanguage.uppercased())
                                        .font(.subheadline)
                                }
                                .padding(.horizontal)
                            }
                            
                            if let runtime = details.runtime {
                                HStack {
                                    Text("Runtime:")
                                        .font(.headline)
                                        .foregroundColor(.secondary)
                                    Text("\(runtime / 60)h \(runtime % 60)m")
                                        .font(.subheadline)
                                }
                                .padding(.horizontal)
                            }
                            
                            if let status = details.status {
                                HStack {
                                    Text("Status:")
                                        .font(.headline)
                                        .foregroundColor(.secondary)
                                    Text(status)
                                        .font(.subheadline)
                                }
                                .padding(.horizontal)
                            }
                            
                            if let productionCompanies = details.productionCompanies {
                                VStack(alignment: .leading) {
                                    Text("Production Companies:")
                                        .font(.headline)
                                        .foregroundColor(.secondary)
                                    ForEach(productionCompanies, id: \.id) { company in
                                        HStack {
                                            if let logoPath = company.logoPath, let url = URL(string: "https://image.tmdb.org/t/p/w200\(logoPath)") {
                                                AsyncImage(url: url) { image in
                                                    image.resizable()
                                                } placeholder: {
                                                    ProgressView()
                                                }
                                                .frame(width: 50, height: 50)
                                                .clipShape(Circle())
                                            }
                                            Text(company.name ?? "")
                                                .font(.subheadline)
                                        }
                                    }
                                }
                                .padding(.horizontal)
                            }
                            
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Overview")
                                    .font(.headline)
                                    .foregroundColor(.secondary)
                                Text(details.overview ?? "")
                                    .font(.body)
                            }
                            .padding(.horizontal)
                            .padding(.bottom, 20)
                        }
                        .background(Color.white)
                        .cornerRadius(20)
                        .padding(.top, -20)

                        Spacer()
                    }
                }
                .background(Color.secondary.opacity(0.1).edgesIgnoringSafeArea(.all))
            } else if viewModel.isLoading {
                ProgressView()
                    .scaleEffect(2)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .edgesIgnoringSafeArea(.top)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.getMovieDetails()
        }
    }
}

//#Preview {
//    MovieDetailView(movie: MoviesResult(id: 0))
//}
