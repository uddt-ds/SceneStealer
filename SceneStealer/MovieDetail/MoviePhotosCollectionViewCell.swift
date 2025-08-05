//
//  TodayMovieCollectionViewCell.swift
//  SceneStealer
//
//  Created by Lee on 8/1/25.
//

import UIKit
import Kingfisher

class MoviePhotosCollectionViewCell: UICollectionViewCell {

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .splash
        imageView.backgroundColor = .primaryWhite
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
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

    private func configureHierarchy() {
        [imageView].forEach { contentView.addSubview($0) }
    }

    private func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func configureView() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }

    func configureCell(data: BackDropData) {
        guard let url = URL(string: data.url) else { return }
        imageView.kf.setImage(with: url)
    }
}
