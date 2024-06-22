//
//  MoviesResponse.swift
//  Core
//
//  Created by AhmadShraby on 6/19/24.
//

import Foundation

// MARK: - MoviesResponse
public struct MoviesResponse: Codable {
    public let dates: Dates?
    public let page: Int?
    public let results: [MoviesResult]?
    public let totalPages, totalResults: Int?
    
    public init(dates: Dates? = nil, page: Int? = nil, results: [MoviesResult]? = nil, totalPages: Int? = nil, totalResults: Int? = nil) {
        self.dates = dates
        self.page = page
        self.results = results
        self.totalPages = totalPages
        self.totalResults = totalResults
    }
    
    public enum CodingKeys: String, CodingKey {
        case dates, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Dates
public struct Dates: Codable {
    public let maximum, minimum: String?
}

// MARK: - Result
public struct MoviesResult: Codable, Identifiable, Equatable {
    public let adult: Bool?
    public let backdropPath: String?
    public let genreIDS: [Int]?
    public let id: Int
    public let originalTitle, overview: String?
    public let popularity: Double?
    public let posterPath, releaseDate, title: String?
    public let video: Bool?
    public let voteAverage: Double?
    public let voteCount: Int?
    
    public init(adult: Bool? = nil, backdropPath: String? = nil, genreIDS: [Int]? = nil, id: Int, originalTitle: String? = nil, overview: String? = nil, popularity: Double? = nil, posterPath: String? = nil, releaseDate: String? = nil, title: String? = nil, video: Bool? = nil, voteAverage: Double? = nil, voteCount: Int? = nil) {
        self.adult = adult
        self.backdropPath = backdropPath
        self.genreIDS = genreIDS
        self.id = id
        self.originalTitle = originalTitle
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.title = title
        self.video = video
        self.voteAverage = voteAverage
        self.voteCount = voteCount
    }
    
    public enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
