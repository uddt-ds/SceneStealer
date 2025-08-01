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
        let popchornImage = ImageSystem.getImage(name: ImageSystem.popcorn.rawValue)
        mainVC.setupTabBarItem(title: "CINEMA", image: popchornImage)

        let upcommingVC = OnboardingVC()
        let filmImage = ImageSystem.getImage(name: ImageSystem.filmStack.rawValue)
        upcommingVC.setupTabBarItem(title: "UPCOMMING", image: filmImage)

        let personVC = NicknameVC()
        let personImage = ImageSystem.getImage(name: ImageSystem.person.rawValue)
        personVC.setupTabBarItem(title: "PEOPLE", image: personImage)

        setViewControllers([mainVC, upcommingVC, personVC], animated: true)
        tabBar.tintColor = .primaryGreen
        tabBar.unselectedItemTintColor = .primaryLightGray
    }
}
