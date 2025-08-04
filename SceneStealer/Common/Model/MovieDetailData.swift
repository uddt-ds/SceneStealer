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
}
