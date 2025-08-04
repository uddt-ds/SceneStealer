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

    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case id
        case title
        case overview
    }
}

extension MovieResult {
    var url: String {
        return APIData.simpleImage(posterPath).getUrlComponents
    }
}
