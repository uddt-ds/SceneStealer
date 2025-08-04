//
//  MoiveDetailData.swift
//  SceneStealer
//
//  Created by Lee on 8/4/25.
//

import Foundation

struct MovieDetailData: Decodable {
    let backdrops: [BackDropData]
}

struct BackDropData: Decodable {
    let filePath: String

    enum CodingKeys: String, CodingKey {
        case filePath = "file_path"
    }

    var url: String {
        return APIData.simpleImage(filePath).getUrlComponents
    }
}

extension MovieDetailData {
    var fiveBackdrops: [BackDropData] {
        let prefixBackdrops = backdrops.prefix(5)
        return [BackDropData](prefixBackdrops)
    }
}
