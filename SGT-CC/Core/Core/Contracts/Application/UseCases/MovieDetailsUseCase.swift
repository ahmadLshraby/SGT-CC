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
