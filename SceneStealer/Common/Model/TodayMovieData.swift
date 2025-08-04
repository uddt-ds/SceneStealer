//
//  TodayMovieData.swift
//  SceneStealer
//
//  Created by Lee on 8/4/25.
//

import Foundation

struct TodayMovieData: Decodable {
    let results: [MovieResult]
}

struct MovieResult: Decodable {
    let posterPath: String
    let id: Int
    let title: String
    let overview: String
    let voteAverage: Double
    let releaseDate: String
    let genreIds: [Int]

    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case id
        case title
        case overview
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
        case genreIds = "genre_ids"
    }
}

extension MovieResult {
    var url: String {
        return APIData.simpleImage(posterPath).getUrlComponents
    }

    var movieDetailModel: MovieDetailModel {
        return .init(id: id, title: title, overview: overview, voteAverage: voteAverage, releaseDate: releaseDate, genre: genreString)
    }

    var genre: [Int] {
        return [Int](genreIds.prefix(2))
    }

    var genreString: String {
        return genre.map { GenreData().genreDictionary[$0] ?? "" }.joined(separator: ", ")
    }
}
