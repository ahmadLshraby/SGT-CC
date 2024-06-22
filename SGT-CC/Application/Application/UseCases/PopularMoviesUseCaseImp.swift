//
//  PopularMoviesUseCaseImp.swift
//  Application
//
//  Created by AhmadShraby on 6/22/24.
//

import Foundation
import Combine
import Core

public class PopularMoviesUseCaseImp: PopularMoviesUseCase {
    private var repository: MoviesRepository

    public init(repository: MoviesRepository) {
        self.repository = repository
    }
    
    public func getPopularMovies(page: Int) -> AnyPublisher<MoviesResponse, NetworkServicesError> {
        return self.repository.getPopularMovies(page: page)
    }
}
