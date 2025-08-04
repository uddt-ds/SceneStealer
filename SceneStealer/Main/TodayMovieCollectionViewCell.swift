//
//  TodayMovieCollectionViewCell.swift
//  SceneStealer
//
//  Created by Lee on 8/1/25.
//

import UIKit
import Kingfisher

class TodayMovieCollectionViewCell: UICollectionViewCell {

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .splash
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .headerTitleLB
        label.textColor = .primaryWhite
        label.textAlignment = .left
        return label
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

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, heartButton])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 8
        return stackView
    }()

    private let synopsisLabel: UILabel = {
        let label = UILabel()
        label.font = .subTitleM
        label.textColor = .primaryWhite
        label.numberOfLines = 3
        label.textAlignment = .left
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureView()
        configureLayoutStackView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func configureHierarchy() {
        [imageView, stackView, synopsisLabel].forEach { contentView.addSubview($0) }
    }

    private func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }

        stackView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.directionalHorizontalEdges.equalToSuperview()
            make.bottom.equalTo(synopsisLabel.snp.top).offset(4)
            make.height.equalTo(20)
        }

        synopsisLabel.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(60)
        }
    }

    private func configureView() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }

    private func configureLayoutStackView() {
        titleLabel.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
        }

        heartButton.snp.makeConstraints { make in
            make.size.equalTo(20)
        }
    }

    func configureCell(data: MovieResult) {
        let url = URL(string: data.url)
        imageView.kf.setImage(with: url)
        titleLabel.text = data.title
        synopsisLabel.text = data.overview
    }
}
