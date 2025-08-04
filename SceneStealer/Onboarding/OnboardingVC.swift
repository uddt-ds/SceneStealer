//
//  OnboardingVC.swift
//  SceneStealer
//
//  Created by Lee on 8/1/25.
//

import UIKit

class OnboardingVC: UIViewController {

    let onboardingView = OnboardingView()

    override func loadView() {
        view = onboardingView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        onboardingView.startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }

    @objc private func startButtonTapped() {
        let nicknameVC = NicknameVC()
        navigationItem.title = ""
        navigationController?.navigationBar.tintColor = .primaryGreen
        navigationController?.pushViewController(nicknameVC, animated: true)
    }
}
