//
//  MainView.swift
//  SceneStealer
//
//  Created by Lee on 8/1/25.
//

import UIKit

class MainView: UIView {

    let profileBoxView = ProfileBoxView()

    let currentSearchLabel: UILabel = {
        let label = UILabel()
        label.text = "최근검색어"
        label.font = .headerTitleLB
        label.textColor = .primaryWhite
        label.textAlignment = .left
        return label
    }()

    let todayMovieLabel: UILabel = {
        let label = UILabel()
        label.text = "오늘의 영화"
        label.font = .headerTitleLB
        label.textColor = .primaryWhite
        label.textAlignment = .left
        return label
    }()

    lazy var searchCollectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: makeSearchCollectionViewFlowLayout())

    lazy var todayMovieCollectionView = UICollectionView(frame: .zero,
                                                    collectionViewLayout: makeMovieCollectionViewFlowLayout())

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
        [profileBoxView, currentSearchLabel, searchCollectionView, todayMovieLabel, todayMovieCollectionView].forEach { addSubview($0)}
    }

    func configureLayout() {
        profileBoxView.snp.makeConstraints { make in
            make.top.directionalHorizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(90)
        }

        currentSearchLabel.snp.makeConstraints { make in
            make.top.equalTo(profileBoxView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
        }

        searchCollectionView.snp.makeConstraints { make in
            make.top.equalTo(currentSearchLabel.snp.bottom).offset(16)
            make.directionalHorizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalToSuperview().multipliedBy(0.03)
        }

        todayMovieLabel.snp.makeConstraints { make in
            make.top.equalTo(searchCollectionView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
        }

        todayMovieCollectionView.snp.makeConstraints { make in
            make.top.equalTo(todayMovieLabel.snp.bottom).offset(12)
            make.directionalHorizontalEdges.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }

    private func configureView() {
        searchCollectionView.register(SearchListCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: SearchListCollectionViewCell.self))
        todayMovieCollectionView.register(TodayMovieCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: TodayMovieCollectionViewCell.self))
        searchCollectionView.backgroundColor = .clear
        todayMovieCollectionView.backgroundColor = .clear
    }

    private func makeSearchCollectionViewFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 4,
                                 height: UIScreen.main.bounds.height * 0.03)
        return layout
    }

    private func makeMovieCollectionViewFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width / 1.5) - 32 - 16,
                                 height: UIScreen.main.bounds.height * 0.5)
        return layout
    }

}
