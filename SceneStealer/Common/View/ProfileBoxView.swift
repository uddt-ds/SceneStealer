//
//  ProfileView.swift
//  SceneStealer
//
//  Created by Lee on 8/1/25.
//

import UIKit
import SnapKit

class ProfileBoxView: UIView, InitialViewProtocol {

    let nicknameLabel: UILabel = {
        let label = UILabel()
        label.text = "닉네임 테스트"
        label.textColor = .primaryWhite
        label.font = .headerTitleLB
        return label
    }()

    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "00.00.00 가입"
        label.textColor = .primaryGray
        label.font = .subTitleS
        label.textAlignment = .right
        return label
    }()

    let setDetailButton: UIButton = {
        let button = UIButton()
        let image = ImageSystem.getImage(name: ImageSystem.chevronR.rawValue)
        let configuration = UIImage.SymbolConfiguration(pointSize: 20)
        button.setImage(image.withConfiguration(configuration), for: .normal)
        button.contentMode = .center
        button.tintColor = .primaryGray
        return button
    }()

    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dateLabel, setDetailButton])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()

    let movieBoxButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .subGreen
        button.setTitle("n개의 무비박스 보관중", for: .normal)
        button.setTitleColor(.primaryWhite, for: .normal)
        button.titleLabel?.font = .headerTitleMB
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.isUserInteractionEnabled = false
        return button
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
        [nicknameLabel, stackView, movieBoxButton].forEach { addSubview($0)}
    }

    func configureLayout() {
        configureStackSubViewLayout()

        nicknameLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(12)
            make.height.equalTo(24)
        }

        stackView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(12)
            make.centerY.equalTo(nicknameLabel)
            make.width.equalTo(100)
        }

        movieBoxButton.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(8)
            make.directionalHorizontalEdges.bottom.equalToSuperview().inset(12)
        }
    }

    private func configureStackSubViewLayout() {
        setDetailButton.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.width.equalTo(20)
        }
    }

    func configureView() {
        layer.cornerRadius = 10
        backgroundColor = .primaryDrakGray
    }
}
