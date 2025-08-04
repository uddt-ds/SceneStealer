//
//  TabBarController.swift
//  SceneStealer
//
//  Created by Lee on 8/1/25.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBarController()
    }

    func configureTabBarController() {
        let mainVC = MainVC()
        let navMain = UINavigationController(rootViewController: mainVC)
        let popchornImage = ImageSystem.getImage(name: ImageSystem.popcorn.rawValue)
        navMain.setupTabBarItem(title: "CINEMA", image: popchornImage)

        let upcomingVC = ViewController()
        let filmImage = ImageSystem.getImage(name: ImageSystem.filmStack.rawValue)
        upcomingVC.setupTabBarItem(title: "UPCOMING", image: filmImage)

        let profileVC = ProfileVC()
        let personImage = ImageSystem.getImage(name: ImageSystem.person.rawValue)
        let navProfile = UINavigationController(rootViewController: profileVC)
        navProfile.setupTabBarItem(title: "PEOPLE", image: personImage)

        setViewControllers([navMain, upcomingVC, navProfile], animated: true)

        tabBar.tintColor = .primaryGreen
        tabBar.unselectedItemTintColor = .primaryLightGray
    }
}
