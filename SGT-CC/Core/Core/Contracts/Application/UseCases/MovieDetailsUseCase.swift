//
//  MovieDetailsUseCase.swift
//  Core
//
//  Created by AhmadShraby on 6/20/24.
//

import Foundation
import Combine

public protocol MovieDetailsUseCase {
    func getMovieDetails(id: Int) -> AnyPublisher<MovieDetailsResponse, NetworkServicesError>
}

public class MovieDetailsUseCaseImp: MovieDetailsUseCase {
    private var repository: MoviesRepository

    public init(repository: MoviesRepository) {
        self.repository = repository
    }
    
    public func getMovieDetails(id: Int) -> AnyPublisher<MovieDetailsResponse, NetworkServicesError> {
        return self.repository.getMovieDetails(id: id)
    }
}
