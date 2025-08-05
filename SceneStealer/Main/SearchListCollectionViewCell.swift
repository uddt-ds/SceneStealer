//
//  SearchListCollectionViewCell.swift
//  SceneStealer
//
//  Created by Lee on 8/1/25.
//

import UIKit
import SnapKit

class SearchListCollectionViewCell: UICollectionViewCell {

    private let button: UIButton = {
        let button = UIButton()

        return button
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
        [button].forEach { contentView.addSubview($0) }
    }

    private func configureLayout() {
        button.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview()
        }
    }

    private func configureView() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }

    func configureSearchButton(text: String) {
        if #available(iOS 15.0, *) {
            var config = UIButton.Configuration.plain()
            let image = ImageSystem.getImage(name: ImageSystem.xmark.rawValue)
            var titleContainer = AttributeContainer()
            titleContainer.font = UIFont.subTitleM
            let title = AttributedString(text, attributes: titleContainer)
            config.attributedTitle = title
            config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 10)
            config.image = image
            config.imagePadding = 4
            config.imagePlacement = .trailing
            config.titleLineBreakMode = .byTruncatingTail
            config.baseForegroundColor = .primaryBlack
            config.background.backgroundColor = .primaryWhite
            config.cornerStyle = .capsule
            button.configuration = config
        } else {
            button.setTitle(text, for: .normal)
            button.setTitleColor(.primaryBlack, for: .normal)
            button.titleLabel?.font = .subTitleM
            let image = ImageSystem.getImage(name: ImageSystem.xmark.rawValue)
            button.setImage(image, for: .normal)
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 0)
            button.tintColor = .primaryBlack
            button.backgroundColor = .primaryWhite
            button.semanticContentAttribute = .forceRightToLeft
            button.titleLabel?.lineBreakMode = .byTruncatingTail
//            button.titleLabel?.adjustsFontSizeToFitWidth = true
            button.layer.cornerRadius = 12
            button.clipsToBounds = true
        }
    }
}
