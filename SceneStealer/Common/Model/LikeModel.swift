//
//  LikeModel.swift
//  SceneStealer
//
//  Created by Lee on 8/5/25.
//

import Foundation

struct LikeModel: Codable {
    private var movieIds: Set<Int> = []
}

extension LikeModel {
    mutating func updateLikeMovie(movieId: Int) {
        if movieIds.contains(movieId) {
            movieIds.remove(movieId)
        } else {
            movieIds.insert(movieId)
        }

        UserDefaultManager.shared.saveData(key: .likeMovies, value: self)
    }

    func isLike(movieId: Int) -> Bool {
        if movieIds.contains(movieId) {
            return true
        } else {
            return false
        }
    }

    func getLikeCount() -> Int {
        return movieIds.count
    }
}
