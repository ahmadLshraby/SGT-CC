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
    
    public func getMovieDetails(endPoint: Core.EndPoint) -> AnyPublisher<Core.MovieDetailsResponse, Core.NetworkServicesError> {
        return apiClient.request(endPoint: endPoint, responseClass: MovieDetailsResponse.self)
    }
}
