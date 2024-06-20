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
    @State private var showAlert = false

    init(viewModel: PopularMoviesViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if !viewModel.movies.isEmpty {
                    List {
                        ForEach(viewModel.movies) { movie in
                            NavigationLink {
                                MovieDetailView(viewModel: container.makeMovieDetailsViewModel(movieID: movie.id))
                                    .environment(\.appDIContainer, container)
                            } label: {
                                MovieRowView(movie: movie)
                            }
                            .onAppear {
                                if movie == viewModel.movies.last && viewModel.canLoadMore && !viewModel.isLoading {
                                    viewModel.fetchNextPage()
                                }
                            }
                        }
                        if viewModel.isLoading {
                            ProgressView()
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                    }
                    .listStyle(.plain)
                } else if viewModel.isLoading {
                    ProgressView()
                        .scaleEffect(2)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .navigationTitle("Popular Movies")
            .onAppear {
                viewModel.fetchPopularMovies()
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text(viewModel.errorMessage ?? "Unknown error"),
                    dismissButton: .default(Text("OK"), action: {
                        viewModel.errorMessage = nil
                    })
                )
            }
        }
        .onChange(of: viewModel.errorMessage) { _ in
            if viewModel.errorMessage != nil {
                showAlert = true
            }
        }
    }
}

//#Preview {
//    PopularMoviesView(viewModel: <#PopularMoviesViewModel#>)
//}
