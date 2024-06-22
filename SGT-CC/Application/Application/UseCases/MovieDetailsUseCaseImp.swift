//
//  MovieDetailsUseCaseImp.swift
//  Application
//
//  Created by AhmadShraby on 6/22/24.
//

import Foundation
import Combine
import Core

public class MovieDetailsUseCaseImp: MovieDetailsUseCase {
    private var repository: MoviesRepository

    public init(repository: MoviesRepository) {
        self.repository = repository
    }
    
    public func getMovieDetails(id: Int) -> AnyPublisher<MovieDetailsResponse, NetworkServicesError> {
        return self.repository.getMovieDetails(id: id)
    }
}
