//
//  MovieDetailModel.swift
//  SceneStealer
//
//  Created by Lee on 8/4/25.
//

import Foundation

struct MovieDetailModel {
    let id: Int
    let title: String
    let overview: String
    let voteAverage: Double
    let releaseDate: String
    let genre: String

    var shortVoteAverage: String {
        return "\(String(format: "%.1f", voteAverage))"
    }
}
