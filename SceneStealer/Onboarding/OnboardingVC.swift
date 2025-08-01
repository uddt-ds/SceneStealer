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
    }
}
