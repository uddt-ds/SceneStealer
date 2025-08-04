//
//  UIFont+Extension.swift
//  SceneStealer
//
//  Created by Lee on 7/31/25.
//

import UIKit

enum FontName: String {
    case logo = "Gill Sans SemiBold Italic"
    case header, text, sub = "Apple SD Gothic Neo"
    case headerEngB = "Noto Sans Kannada"
    case headerB = "Apple SD Gothic Neo Bold"
    case eng = "Courier New Bold"
}

extension UIFont {
    static let logoTitle = UIFont(name: FontName.logo.rawValue, size: 30)
    static let headerTitleLB = UIFont(name: FontName.headerB.rawValue, size: 16)
    static let headerTitleL = UIFont(name: FontName.header.rawValue, size: 16)
    static let headerTitleMB = UIFont(name: FontName.headerB.rawValue, size: 14)
    static let headerTitleM = UIFont(name: FontName.header.rawValue, size: 14)
    static let headerTitleSB = UIFont(name: FontName.headerB.rawValue, size: 12)
    static let headerEngTitleSB = UIFont(name: FontName.headerEngB.rawValue, size: 12)
    static let headerTitleXsB = UIFont(name: FontName.headerB.rawValue, size: 10)
    static let textTitle = UIFont(name: FontName.text.rawValue, size: 14)
    static let subTitleM = UIFont(name: FontName.sub.rawValue, size: 12)
    static let subTitleS = UIFont(name: FontName.sub.rawValue, size: 10)
    static let engTitle = UIFont(name: FontName.eng.rawValue, size: 10)
}

