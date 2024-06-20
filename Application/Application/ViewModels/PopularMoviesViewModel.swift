//
//  PopularMoviesViewModel.swift
//  Application
//
//  Created by AhmadShraby on 6/19/24.
//

import Foundation
import Combine
import Core

public final class PopularMoviesViewModel: ObservableObject {
    @Published public var movies: [MoviesResult] = []
    @Published public var isLoading: Bool = false
    @Published public var errorMessage: String? = nil
    private var currentPage = 1
    private var totalPages = 1
    public var canLoadMore: Bool {
        !isLoading && currentPage < totalPages
    }
    private var cancellables = Set<AnyCancellable>()
    
    private var useCase: PopularMoviesUseCase
    
    public init(useCase: PopularMoviesUseCase) {
        self.useCase = useCase
    }
    
    public func fetchPopularMovies() {
        isLoading = true
        self.useCase.getPopularMovies(endPoint: PopularMoviesEndPoint(page: currentPage))
            .receive(on: DispatchQueue.main)
            .sink { completion in
                self.isLoading = false
                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            } receiveValue: { response in
                self.movies = response.results ?? []
                self.totalPages = response.totalPages ?? 1
            }
            .store(in: &cancellables)
    }
    
    public func fetchNextPage() {
        isLoading = true
        currentPage += 1
        self.useCase.getPopularMovies(endPoint: PopularMoviesEndPoint(page: currentPage))
            .receive(on: DispatchQueue.main)
            .sink { completion in
                self.isLoading = false
                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            } receiveValue: { response in
                self.movies.append(contentsOf: response.results ?? [])
            }
            .store(in: &cancellables)
    }
}

class PopularMoviesEndPoint: EndPoint {
    var path: String
    var method: Core.NetworkRequestMethod
    var headers: [String : Any]?
    var parameters: [String : Any]?
    
    init(page: Int) {
        let baseURL = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String ?? "Not found"
        let token = Bundle.main.object(forInfoDictionaryKey: "ACCESS_TOKEN") as? String ?? "Not found"
        self.path = "\(baseURL)movie/now_playing?language=en-US&page=\(page)"
        self.method = .get
        self.headers = ["Authorization": "Bearer \(token)"]
        self.parameters = nil
    }
}
