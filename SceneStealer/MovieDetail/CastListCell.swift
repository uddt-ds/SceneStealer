//
//  CastListCell.swift
//  SceneStealer
//
//  Created by Lee on 8/3/25.
//

import UIKit

class CastListCell: UITableViewCell, ReusableViewProtocol {

    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .primaryDrakGray
        imageView.layer.cornerRadius = 22
        imageView.clipsToBounds = true
        return imageView
    }()

    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .primaryWhite
        label.font = .headerTitleMB
        return label
    }()

    private let engLabel: UILabel = {
        let label = UILabel()
        label.textColor = .primaryGray
        label.font = .engTitle
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [profileImageView, label, engLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
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
        [stackView].forEach { contentView.addSubview($0) }
    }

    private func configureLayout() {
        configureStackViewLayout()

        stackView.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
            make.directionalVerticalEdges.equalToSuperview().inset(8)
        }
    }

    private func configureStackViewLayout() {
        profileImageView.snp.makeConstraints { make in
            make.size.equalTo(44)
        }

        label.snp.makeConstraints { make in
            make.height.equalTo(22)
        }

        engLabel.snp.makeConstraints { make in
            make.height.equalTo(22)
        }

        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        engLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
    }

    private func configureView() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }

    func configureCell(data: CastList) {
        let url = URL(string: data.url)
        profileImageView.kf.setImage(with: url)
        label.text = data.name
        engLabel.text = data.character
    }
}
