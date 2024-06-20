//
//  DefaultPopularMovies.swift
//  Infrastructure
//
//  Created by AhmadShraby on 6/19/24.
//

import Foundation
import Combine
import Core

public final class DefaultPopularMovies: PopularMoviesRepository {
    private let apiClient: APIContract
    
    public init(apiClient: APIContract) {
        self.apiClient = apiClient
    }
    
    public func getPopularMovies(endPoint: Core.EndPoint) -> AnyPublisher<Core.MoviesResponse, Core.NetworkServicesError> {
        return apiClient.request(endPoint: endPoint, responseClass: MoviesResponse.self)
    }
}
