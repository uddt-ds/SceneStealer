//
//  primaryButton.swift
//  SceneStealer
//
//  Created by Lee on 7/31/25.
//

import UIKit

class PrimaryButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    init(title: String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        designButtonUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func designButtonUI() {
        setTitleColor(.primaryGreen, for: .normal)
        titleLabel?.font = .headerTitleSB
        layer.cornerRadius = 20
        layer.borderWidth = 2
        layer.borderColor = UIColor.primaryGreen.cgColor
        backgroundColor = .clear
    }

}
