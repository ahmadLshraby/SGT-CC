//
//  PopularMoviesEndPoints.swift
//  Core
//
//  Created by AhmadShraby on 6/19/24.
//

import Foundation

public protocol PopularMoviesEndpointsContract {
    func getPopularMovies(page: Int) -> EndPoint
}
