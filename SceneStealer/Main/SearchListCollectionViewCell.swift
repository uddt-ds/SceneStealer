//
//  SearchListCollectionViewCell.swift
//  SceneStealer
//
//  Created by Lee on 8/1/25.
//

import UIKit
import SnapKit

class SearchListCollectionViewCell: UICollectionViewCell {

    let label: UILabel = {
        let label = UILabel()
        label.font = .subTitleM
        label.textColor = .primaryBlack
        label.textAlignment = .center
        return label
    }()

    let deleteButton: UIButton = {
        let button = UIButton()
        let image = ImageSystem.getImage(name: ImageSystem.xmark.rawValue)
        button.setImage(image, for: .normal)
        button.tintColor = .black
        button.backgroundColor = .clear
        return button
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [label, deleteButton])
        stackView.axis = .horizontal
        stackView.spacing = 3
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 0, left: 6, bottom: 0, right: 6)
        stackView.backgroundColor = .primaryWhite
        stackView.layer.cornerRadius = 12
        stackView.clipsToBounds = true
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func configureHierarchy() {
        [stackView].forEach { contentView.addSubview($0) }
    }

    private func configureLayout() {
        stackView.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview()
        }

        deleteButton.snp.makeConstraints { make in
            make.size.equalTo(12)
        }
    }

    private func configureView() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }

    func configureSearchListLabel(text: String) {
        label.text = text
    }
}
