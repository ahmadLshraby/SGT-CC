//
//  PopularMoviesUseCase.swift
//  Core
//
//  Created by AhmadShraby on 6/19/24.
//

import Foundation
import Combine

public protocol PopularMoviesUseCase {
    func getPopularMovies(page: Int) -> AnyPublisher<MoviesResponse, NetworkServicesError>
}

public class PopularMoviesUseCaseImp: PopularMoviesUseCase {
    private var repository: MoviesRepository

    public init(repository: MoviesRepository) {
        self.repository = repository
    }
    
    public func getPopularMovies(page: Int) -> AnyPublisher<MoviesResponse, NetworkServicesError> {
        return self.repository.getPopularMovies(page: page)
    }
}
