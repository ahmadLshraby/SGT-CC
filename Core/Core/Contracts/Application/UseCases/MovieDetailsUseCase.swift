//
//  MovieDetailsUseCase.swift
//  Core
//
//  Created by AhmadShraby on 6/20/24.
//

import Foundation
import Combine

public protocol MovieDetailsUseCase {
    func getMovieDetails(endPoint: EndPoint) -> AnyPublisher<MovieDetailsResponse, NetworkServicesError>
}

public class MovieDetailsUseCaseImp: MovieDetailsUseCase {
    private var repository: MovieDetailsRepository

    public init(repository: MovieDetailsRepository) {
        self.repository = repository
    }
    
    public func getMovieDetails(endPoint: EndPoint) -> AnyPublisher<MovieDetailsResponse, NetworkServicesError> {
        return self.repository.getMovieDetails(endPoint: endPoint)
    }
}
