//
//  SynopsisCell.swift
//  SceneStealer
//
//  Created by Lee on 8/2/25.
//

import UIKit
import SnapKit

class SynopsisCell: UITableViewCell {

    private let label: UILabel = {
        let label = UILabel()
        label.text = "Synopsis"
        label.textColor = .primaryWhite
        label.font = .headerTitleMB
        return label
    }()

    let moreButton: UIButton = {
        let button = UIButton()
        button.setTitle("More", for: .normal)
        button.setTitleColor(.primaryGreen, for: .normal)
        button.titleLabel?.font = .headerTitleMB
        return button
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [label, moreButton])
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.alignment = .center
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
        stackView.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
            make.directionalVerticalEdges.equalToSuperview().inset(8)
        }
    }

    private func configureView() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }
}
