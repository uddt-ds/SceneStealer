//
//  SearchResult.swift
//  SceneStealer
//
//  Created by Lee on 8/2/25.
//

import UIKit

class SearchResultView: UIView, InitialViewProtocol {

    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        let placeHolder = NSAttributedString(string: "영화 제목을 검색해주세요",
                                             attributes: [.foregroundColor: UIColor.primaryLightGray])
        searchBar.searchTextField.attributedPlaceholder = placeHolder
        searchBar.placeholder = "영화 제목을 검색해주세요"
        searchBar.backgroundImage = UIImage()
        searchBar.searchTextField.backgroundColor = .primaryGray
        searchBar.searchTextField.leftView?.tintColor = .primaryLightGray
        return searchBar
    }()

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UIScreen.main.bounds.height / 5.5
        return tableView
    }()

    let label: UILabel = {
        let label = UILabel()
        label.text = "원하는 검색결과를 찾지 못했습니다"
        label.font = .subTitleM
        label.textColor = .primaryGray
        label.textAlignment = .center
        label.isHidden = true
        return label
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

    func configureHierarchy() {
        [searchBar, tableView, label].forEach { addSubview($0) }
    }

    func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.directionalHorizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(44)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.directionalHorizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }

        label.snp.makeConstraints { make in
            make.center.equalTo(tableView.snp.center)
        }

    }

    func configureView() {
        backgroundColor = .primaryBlack
    }

}
