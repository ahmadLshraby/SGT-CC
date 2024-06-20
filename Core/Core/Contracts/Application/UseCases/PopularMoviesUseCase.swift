//
//  PopularMoviesUseCase.swift
//  Core
//
//  Created by AhmadShraby on 6/19/24.
//

import Foundation
import Combine

public protocol PopularMoviesUseCase {
    func getPopularMovies(endPoint: EndPoint) -> AnyPublisher<MoviesResponse, NetworkServicesError>
}

public class PopularMoviesUseCaseImp: PopularMoviesUseCase {
    private var repository: PopularMoviesRepository

    public init(repository: PopularMoviesRepository) {
        self.repository = repository
    }
    
    public func getPopularMovies(endPoint: EndPoint) -> AnyPublisher<MoviesResponse, NetworkServicesError> {
        return self.repository.getPopularMovies(endPoint: endPoint)
    }
}
