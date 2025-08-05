//
//  SplashView.swift
//  SceneStealer
//
//  Created by Lee on 8/4/25.
//

import UIKit

class SplashView: UIView, InitialViewProtocol {

    var userName: String? = "이다성"

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .splash
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    let logoLabel: UILabel = {
        let label = UILabel()
        label.text = "SceneStealer"
        label.font = .logoTitle
        label.textColor = .primaryWhite
        label.textAlignment = .center
        return label
    }()

    private lazy var subLabel: UILabel = {
        let label = UILabel()
        label.text = self.userName
        label.font = .subTitleM
        label.textColor = .primaryWhite
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func configureHierarchy() {
        [imageView, logoLabel, subLabel].forEach { addSubview($0) }
    }

    func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(280)
            make.centerX.equalToSuperview()
            make.size.equalTo(150)
        }

        logoLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(100)
            make.centerX.equalToSuperview()
            make.height.equalTo(36)
        }

        subLabel.snp.makeConstraints { make in
            make.top.equalTo(logoLabel.snp.bottom).offset(20)
            make.directionalHorizontalEdges.equalToSuperview().inset(80)
            make.height.equalTo(32)
        }
    }

    func configureView() {
        backgroundColor = .primaryBlack
    }
}
