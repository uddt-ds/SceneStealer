//
//  SynopsisLabelCell.swift
//  SceneStealer
//
//  Created by Lee on 8/3/25.
//

import UIKit

class SynopsisLabelCell: UITableViewCell {

    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .primaryWhite
        label.font = .subTitleM
        label.numberOfLines = 3
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

    func configureCell(data: MovieDetailModel, isExpended: Bool) {
        label.text = data.overview
        if isExpended {
            label.numberOfLines = 0
        } else {
            label.numberOfLines = 3
        }
    }
}

