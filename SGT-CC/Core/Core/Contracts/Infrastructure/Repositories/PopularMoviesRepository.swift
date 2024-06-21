//
//  PopularMoviesRepository.swift
//  Core
//
//  Created by AhmadShraby on 6/19/24.
//

import Foundation
import Combine

public protocol PopularMoviesRepository {
    func getPopularMovies(page: Int) -> AnyPublisher<MoviesResponse, NetworkServicesError>
}
