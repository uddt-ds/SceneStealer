//
//  ImageTitle.swift
//  SceneStealer
//
//  Created by Lee on 7/31/25.
//

import UIKit

enum ImageSystem: String {
    case heart = "heart"
    case fillHeart = "heart.fill"
    case star = "star.fill"
    case camera = "camera.fill"
    case xmark = "xmark"
    case film = "film.fill"
    case magnifyingglass = "magnifyingglass"
    case calender = "calender"
    case popcorn = "popcorn"
    case filmStack = "film.stack"
    case person = "person.crop.circle"
    case chevronL = "chevron.backward"
    case chevronR = "chevron.forward"

    static func getImage(name: ImageSystem.RawValue) -> UIImage {
        guard let image = UIImage(systemName: name) else { return UIImage() }
        return image
    }
}
