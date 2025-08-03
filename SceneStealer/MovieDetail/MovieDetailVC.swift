//
//  MovieDetailVC.swift
//  SceneStealer
//
//  Created by Lee on 8/2/25.
//

import UIKit

class MovieDetailVC: UIViewController {

    let movieDetailView = MovieDetailView()

    override func loadView() {
        view = movieDetailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        movieDetailView.tableView.register(SynopsisCell.self, forCellReuseIdentifier: String(describing: SynopsisCell.self))
        movieDetailView.tableView.register(SynopsisLabelCell.self, forCellReuseIdentifier: String(describing: SynopsisLabelCell.self))
        movieDetailView.tableView.register(CastCell.self, forCellReuseIdentifier: String(describing: CastCell.self))
        movieDetailView.tableView.register(CastListCell.self, forCellReuseIdentifier: String(describing: CastListCell.self))
        movieDetailView.tableView.dataSource = self
        movieDetailView.tableView.delegate = self
    }

    private func configureView() {
        view.backgroundColor = .black
    }

}

extension MovieDetailVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        switch row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SynopsisCell.self), for: indexPath) as? SynopsisCell else { return .init() }
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SynopsisLabelCell.self), for: indexPath) as? SynopsisLabelCell else { return .init() }
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CastCell.self), for: indexPath) as? CastCell else { return .init() }
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CastListCell.self), for: indexPath) as? CastListCell else { return .init() }
            return cell
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: MovieDetailHeaderView.self)) as? MovieDetailHeaderView else { return .init() }
        headerView.imageCollectionView.delegate = self
        headerView.imageCollectionView.dataSource = self
        headerView.imageCollectionView.isPagingEnabled = true
        headerView.imageCollectionView.register(MoviePhotosCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: MoviePhotosCollectionViewCell.self))
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 250
    }
}

extension MovieDetailVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MoviePhotosCollectionViewCell.self), for: indexPath) as? MoviePhotosCollectionViewCell else { return .init() }
        return cell
    }
}
