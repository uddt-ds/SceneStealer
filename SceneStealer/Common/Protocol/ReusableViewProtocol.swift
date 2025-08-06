//
//  ReusableViewProtocl.swift
//  SceneStealer
//
//  Created by Lee on 8/6/25.
//

import UIKit

protocol ReusableViewProtocol: AnyObject {
    static var identifier: String { get }
}

extension ReusableViewProtocol {
    static var identifier: String {
        return String(describing: Self.self)
    }
}
