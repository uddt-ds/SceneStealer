//
//  SynopsisCell.swift
//  SceneStealer
//
//  Created by Lee on 8/2/25.
//

import UIKit
import SnapKit

class CastCell: UITableViewCell {

    private let label: UILabel = {
        let label = UILabel()
        label.text = "Cast"
        label.textColor = .primaryWhite
        label.font = .headerTitleMB
        return label
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
        [label].forEach { contentView.addSubview($0) }
    }

    private func configureLayout() {
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
    }

    private func configureView() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }
}
