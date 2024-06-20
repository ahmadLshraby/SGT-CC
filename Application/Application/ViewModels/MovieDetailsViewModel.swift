//
//  MovieDetailsViewModel.swift
//  Application
//
//  Created by AhmadShraby on 6/20/24.
//

import Foundation
import Combine
import Core

public final class MovieDetailsViewModel: ObservableObject {
    @Published public var movieDetails: MovieDetailsResponse?
    @Published public var isLoading: Bool = false
    @Published public var errorMessage: String? = nil

    private var cancellables = Set<AnyCancellable>()
    private var movieID: Int
    private var useCase: MovieDetailsUseCase
    
    public init(useCase: MovieDetailsUseCase,
                movieID: Int) {
        self.useCase = useCase
        self.movieID = movieID
    }
    
    public func getMovieDetails() {
        isLoading = true
        self.useCase.getMovieDetails(endPoint: MovieDetailsEndPoint(id: movieID))
            .receive(on: DispatchQueue.main)
            .sink { completion in
                self.isLoading = false
                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            } receiveValue: { response in
                self.movieDetails = response
            }
            .store(in: &cancellables)
    }
}

class MovieDetailsEndPoint: EndPoint {
    var path: String
    var method: Core.NetworkRequestMethod
    var headers: [String : Any]?
    var parameters: [String : Any]?
    
    init(id: Int) {
        let baseURL = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String ?? "Not found"
        let token = Bundle.main.object(forInfoDictionaryKey: "ACCESS_TOKEN") as? String ?? "Not found"
        self.path = "\(baseURL)movie/\(id)?language=en-US"
        self.method = .get
        self.headers = ["Authorization": "Bearer \(token)"]
        self.parameters = nil
    }
}
