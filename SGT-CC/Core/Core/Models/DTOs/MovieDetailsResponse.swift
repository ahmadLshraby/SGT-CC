//
//  MovieDetailsResponse.swift
//  Core
//
//  Created by AhmadShraby on 6/20/24.
//

import Foundation

// MARK: - MovieDetailsResponse
public struct MovieDetailsResponse: Codable {
    public let adult: Bool?
    public let backdropPath: String?
    public let budget: Int?
    public let genres: [Genre]?
    public let homepage: String?
    public let id: Int?
    public let imdbID: String?
    public let originalLanguage, originalTitle, overview: String?
    public let popularity: Double?
    public let posterPath: String?
    public let productionCompanies: [ProductionCompany]?
    public let releaseDate: String?
    public let revenue, runtime: Int?
    public let status, tagline, title: String?
    public let video: Bool?
    public let voteAverage: Double?
    public let voteCount: Int?

    public init(adult: Bool? = nil, backdropPath: String? = nil, budget: Int? = nil, genres: [Genre]? = nil, homepage: String? = nil, id: Int? = nil, imdbID: String? = nil, originalLanguage: String? = nil, originalTitle: String? = nil, overview: String? = nil, popularity: Double? = nil, posterPath: String? = nil, productionCompanies: [ProductionCompany]? = nil, releaseDate: String? = nil, revenue: Int? = nil, runtime: Int? = nil, status: String? = nil, tagline: String? = nil, title: String? = nil, video: Bool? = nil, voteAverage: Double? = nil, voteCount: Int? = nil) {
        self.adult = adult
        self.backdropPath = backdropPath
        self.budget = budget
        self.genres = genres
        self.homepage = homepage
        self.id = id
        self.imdbID = imdbID
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.productionCompanies = productionCompanies
        self.releaseDate = releaseDate
        self.revenue = revenue
        self.runtime = runtime
        self.status = status
        self.tagline = tagline
        self.title = title
        self.video = video
        self.voteAverage = voteAverage
        self.voteCount = voteCount
    }
    
    public enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case budget, genres, homepage, id
        case imdbID = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case releaseDate = "release_date"
        case revenue, runtime
        case status, tagline, title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

// MARK: - Genre
public struct Genre: Codable {
    public let id: Int
    public let name: String?
}

// MARK: - ProductionCompany
public struct ProductionCompany: Codable {
    public let id: Int
    public let logoPath, name, originCountry: String?

    public enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}
