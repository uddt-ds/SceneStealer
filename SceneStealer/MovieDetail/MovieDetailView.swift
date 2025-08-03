//
//  MovieDetailView.swift
//  SceneStealer
//
//  Created by Lee on 8/2/25.
//

import UIKit
import SnapKit

class MovieDetailView: UIView, InitialViewProtocol {

    let tableView = UITableView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureView()

        tableView.register(MovieDetailHeaderView.self,
                           forHeaderFooterViewReuseIdentifier: String(describing: MovieDetailHeaderView.self))
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func configureHierarchy() {
        [tableView].forEach { addSubview($0) }
    }

    func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }

    func configureView() {
        tableView.backgroundColor = .clear
        backgroundColor = .clear
    }

}
