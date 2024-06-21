//
//  MovieDetailsRepository.swift
//  Core
//
//  Created by AhmadShraby on 6/20/24.
//

import Foundation
import Combine

public protocol MovieDetailsRepository {
    func getMovieDetails(id: Int) -> AnyPublisher<MovieDetailsResponse, NetworkServicesError>
}
