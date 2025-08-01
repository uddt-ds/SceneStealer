//
//  UIViewController+Extension.swift
//  SceneStealer
//
//  Created by Lee on 8/1/25.
//

import UIKit

extension UIViewController {
    func setupTabBarItem(title: String, image: UIImage) {
        tabBarItem.title = title
        tabBarItem.image = image
        tabBarController?.tabBar.tintColor = .primaryGreen
        tabBarController?.tabBar.unselectedItemTintColor = .primaryLightGray
    }
}
