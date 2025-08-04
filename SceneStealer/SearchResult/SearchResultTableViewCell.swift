//
//  SearchResultTableViewCell.swift
//  SceneStealer
//
//  Created by Lee on 8/2/25.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {

    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .primaryDrakGray
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "테스트"
        label.textColor = .primaryWhite
        label.font = .headerTitleSB
        label.numberOfLines = 2
        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "00.00.00"
        label.font = .subTitleS
        label.textColor = .primaryLightGray
        return label
    }()

    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, dateLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        return stackView
    }()

    private let genreButton1: UIButton = {
        let button = UIButton()
        button.setTitle("테스트", for: .normal)
        button.setTitleColor(.primaryWhite, for: .normal)
        button.titleLabel?.font = .subTitleM
        button.backgroundColor = .primaryDrakGray
        button.layer.cornerRadius = 4
        button.isUserInteractionEnabled = false
        button.contentEdgeInsets = .init(top: 0, left: 4, bottom: 0, right: 4)
        button.adjustsImageSizeForAccessibilityContentSizeCategory = true
        return button
    }()

    private let genreButton2: UIButton = {
        let button = UIButton()
        button.setTitle("테스트", for: .normal)
        button.setTitleColor(.primaryWhite, for: .normal)
        button.titleLabel?.font = .subTitleM
        button.backgroundColor = .primaryDrakGray
        button.layer.cornerRadius = 4
        button.isUserInteractionEnabled = false
        button.contentEdgeInsets = .init(top: 0, left: 4, bottom: 0, right: 4)
        button.adjustsImageSizeForAccessibilityContentSizeCategory = true
        return button
    }()

    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [genreButton1, genreButton2])
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        return stackView
    }()

    private let heartButton: UIButton = {
        let button = UIButton()
        let image = ImageSystem.getImage(name: ImageSystem.heart.rawValue)
        let fillImage = ImageSystem.getImage(name: ImageSystem.fillHeart.rawValue)
        button.setImage(image, for: .normal)
        button.setImage(fillImage, for: .selected)
        button.tintColor = .primaryGreen
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierarchy()
        configureLayout()
        configureView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func configureHierarchy() {
        [movieImageView, labelStackView, buttonStackView, heartButton].forEach { contentView.addSubview($0) }
    }

    private func configureLayout() {
        configureLayoutLabelStackView()
        configureLayoutButtonStackView()

        movieImageView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview().inset(16)
            make.width.equalTo(100)
        }

        labelStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalTo(movieImageView.snp.trailing).offset(16)
            make.bottom.lessThanOrEqualTo(buttonStackView.snp.top).offset(-16)
        }

        buttonStackView.snp.makeConstraints { make in
            make.leading.equalTo(labelStackView.snp.leading)
            make.bottom.equalToSuperview().inset(16)
            make.height.equalTo(28)
            make.trailing.lessThanOrEqualTo(heartButton.snp.leading).offset(-16)
        }

        heartButton.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview().inset(16)
            make.size.equalTo(28)
        }
    }

    private func configureView() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }

    private func configureLayoutLabelStackView() {
        dateLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.leading)
            make.height.equalTo(20)
        }
    }

    private func configureLayoutButtonStackView() {
        genreButton1.snp.makeConstraints { make in
            make.height.equalTo(28)
        }

        genreButton2.snp.makeConstraints { make in
            make.height.equalTo(28)
        }
    }

    func configureCell(data: SearchData) {
        guard let url = URL(string: data.url) else { return }
        movieImageView.kf.setImage(with: url)
        titleLabel.text = data.title
        dateLabel.text = data.releaseDate

        if data.genreString.count < 2 {
            genreButton1.setTitle(data.genreString[0], for: .normal)
            genreButton2.isHidden = true
        } else {
            genreButton1.setTitle(data.genreString[0], for: .normal)
            genreButton2.isHidden = false
            genreButton2.setTitle(data.genreString[1], for: .normal)
        }


    }
}
