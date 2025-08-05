//
//  SearchMovieData.swift
//  SceneStealer
//
//  Created by Lee on 8/4/25.
//

import Foundation

struct SearchMovieData: Decodable {
    let results: [SearchData]
    let totalPages: Int
    let totalPagesResult: Int

    enum CodingKeys: String, CodingKey {
        case results
        case totalPages = "total_pages"
        case totalPagesResult = "total_results"
    }
}

struct SearchData: Decodable {
    let id: Int
    let posterPath: String
    let title: String
    let overview: String
    let voteAverage: Double
    let releaseDate: String
    let genreIds: [Int]

    enum CodingKeys: String, CodingKey {
        case id 
        case posterPath = "poster_path"
        case title
        case overview
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
        case genreIds = "genre_ids"
    }
}

extension SearchData {
    var url: String {
        return APIData.simpleImage(posterPath).getUrlComponents
    }

    var genre: [Int] {
        return [Int](genreIds.prefix(2))
    }

    var genreString: [String] {
        return genre.map { GenreData().genreDictionary[$0] ?? "" }
    }

    var movieDetailData: MovieDetailModel {
        return .init(id: id, title: title, overview: overview, voteAverage: voteAverage, releaseDate: releaseDate, genre: genreString.joined(separator: ", "))
    }
}
