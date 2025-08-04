//
//  CastData.swift
//  SceneStealer
//
//  Created by Lee on 8/4/25.
//

import Foundation

struct CastData: Decodable {
    let cast: [CastList]
}

struct CastList: Decodable {
    let name: String
    let profilePath: String?
    let character: String

    enum CodingKeys: String,CodingKey {
        case name
        case profilePath = "profile_path"
        case character
    }
}

extension CastList {
    var url: String {
        return APIData.simpleImage(profilePath ?? "").getUrlComponents
    }
}
