//
//  DefaultMovieDetails.swift
//  Infrastructure
//
//  Created by AhmadShraby on 6/20/24.
//

import Foundation
import Combine
import Core

public final class DefaultMovieDetails: MovieDetailsRepository {
    private let apiClient: APIContract
    
    public init(apiClient: APIContract) {
        self.apiClient = apiClient
    }
    
    public func getMovieDetails(id: Int) -> AnyPublisher<Core.MovieDetailsResponse, Core.NetworkServicesError> {
        let endPoint = App_EndPoints.Movies.getMovieDetails(id: id)
        return apiClient.request(endPoint: endPoint, responseClass: MovieDetailsResponse.self)
    }
}
