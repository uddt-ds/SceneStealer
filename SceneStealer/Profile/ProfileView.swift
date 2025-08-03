//
//  ProfileView.swift
//  SceneStealer
//
//  Created by Lee on 8/3/25.
//

import UIKit

class ProfileView: UIView, InitialViewProtocol {

    private let profileBoxView = ProfileBoxView()

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ProfileTableViewCell.self,
                           forCellReuseIdentifier: String(describing: ProfileTableViewCell.self))
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = .init(top: 0, left: 16, bottom: 0, right: 0)
        tableView.separatorColor = .primaryWhite
        return tableView
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

    func configureHierarchy() {
        [profileBoxView, tableView].forEach { addSubview($0) }
    }

    func configureLayout() {
        profileBoxView.snp.makeConstraints { make in
            make.top.directionalHorizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(90)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(profileBoxView.snp.bottom).offset(16)
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }

    func configureView() {
        tableView.backgroundColor = .clear
    }
    
}
