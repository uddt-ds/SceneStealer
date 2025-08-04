//
//  SplashVC.swift
//  SceneStealer
//
//  Created by Lee on 8/4/25.
//

import UIKit

class SplashVC: UIViewController {

    var isOnboarding: Bool = false

    let splashView = SplashView()

    override func loadView() {
        view = splashView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let data: UserModel = try? UserDefaultManager.shared.loadData(key: .userInfo) else { return }
        isOnboarding = data.isOnboarding
    }

}
