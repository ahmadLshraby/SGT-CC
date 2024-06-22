//
//  MoviesRepository.swift
//  Core
//
//  Created by AhmadShraby on 6/19/24.
//

import Foundation
import Combine

public protocol MoviesRepository {
    func getPopularMovies(page: Int) -> AnyPublisher<MoviesResponse, NetworkServicesError>
    func getMovieDetails(id: Int) -> AnyPublisher<MovieDetailsResponse, NetworkServicesError>
}
