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
public struct MoviesResult: Codable, Identifiable {
    public let adult: Bool?
    public let backdropPath: String?
    public let genreIDS: [Int]?
    public let id: Int?
    public let originalLanguage: OriginalLanguage?
    public let originalTitle, overview: String?
    public let popularity: Double?
    public let posterPath, releaseDate, title: String?
    public let video: Bool?
    public let voteAverage: Double?
    public let voteCount: Int?
    
    public enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
