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
    @Published public var errorMessage: String? = nil
    private var cancellables = Set<AnyCancellable>()
    
    private var useCase: PopularMoviesUseCase
    
    public init(useCase: PopularMoviesUseCase) {
        self.useCase = useCase
    }

    public func fetchPopularMovies() {
        self.useCase.getPopularMovies(endPoint: PopularMoviesEndPoint())
            .sink { completion in
                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            } receiveValue: { response in
                DispatchQueue.main.async {
                    self.movies = response.results ?? []
                }
            }
            .store(in: &cancellables)
    }
}

class PopularMoviesEndPoint: EndPoint {
    var path: String
    var method: Core.NetworkRequestMethod
    var headers: [String : Any]?
    var parameters: [String : Any]?
    
    init() {
        let baseURL = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String ?? "Not found"
        let token = Bundle.main.object(forInfoDictionaryKey: "ACCESS_TOKEN") as? String ?? "Not found"
        self.path = "\(baseURL)movie/now_playing?language=en-US&page=1"
        self.method = .get
        self.headers = ["Authorization": "Bearer \(token)"]
        self.parameters = nil
    }
}
