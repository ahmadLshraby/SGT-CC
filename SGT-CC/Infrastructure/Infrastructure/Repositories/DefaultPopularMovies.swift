//
//  DefaultPopularMovies.swift
//  Infrastructure
//
//  Created by AhmadShraby on 6/19/24.
//

import Foundation
import Combine
import Core

public final class DefaultPopularMovies: MoviesRepository {
    private let apiClient: APIContract
    
    public init(apiClient: APIContract) {
        self.apiClient = apiClient
    }
    
    public func getPopularMovies(page: Int) -> AnyPublisher<Core.MoviesResponse, Core.NetworkServicesError> {
        let endPoint = App_EndPoints.Movies.getPopularMovies(page: page)
        return apiClient.request(endPoint: endPoint, responseClass: MoviesResponse.self)
    }
    
    public func getMovieDetails(id: Int) -> AnyPublisher<Core.MovieDetailsResponse, Core.NetworkServicesError> {
        let endPoint = App_EndPoints.Movies.getMovieDetails(id: id)
        return apiClient.request(endPoint: endPoint, responseClass: MovieDetailsResponse.self)
    }
}
