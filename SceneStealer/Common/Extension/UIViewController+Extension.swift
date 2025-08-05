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

    func showAlert(title: String, message: String, handler: @escaping ((UIAlertAction) -> Void)) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let no = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: "확인", style: .destructive, handler: handler)
        alert.addAction(no)
        alert.addAction(ok)
        present(alert, animated: true)
    }
}
