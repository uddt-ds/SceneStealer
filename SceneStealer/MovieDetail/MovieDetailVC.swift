//
//  MovieDetailVC.swift
//  SceneStealer
//
//  Created by Lee on 8/2/25.
//

import UIKit

class MovieDetailVC: UIViewController {

    var movieDetailData: MovieDetailModel = .init(id: 0, title: "", overview: "", voteAverage: 0.0, releaseDate: "", genre: "")

    var backdrops: [BackDropData] = []
    var castList: [CastList] = []

    var isExpended: Bool = false
    var isLiked: Bool = false

    var headerView: MovieDetailHeaderView?

    let movieDetailView = MovieDetailView()

    override func loadView() {
        view = movieDetailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        fetchBackdropPhotos()
        fetchCast()
        setupNavigation()
        movieDetailView.tableView.register(SynopsisCell.self, forCellReuseIdentifier: String(describing: SynopsisCell.self))
        movieDetailView.tableView.register(SynopsisLabelCell.self, forCellReuseIdentifier: String(describing: SynopsisLabelCell.self))
        movieDetailView.tableView.register(CastCell.self, forCellReuseIdentifier: String(describing: CastCell.self))
        movieDetailView.tableView.register(CastListCell.self, forCellReuseIdentifier: String(describing: CastListCell.self))
        movieDetailView.tableView.dataSource = self
        movieDetailView.tableView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        movieDetailView.tableView.reloadData()
    }

    private func configureView() {
        view.backgroundColor = .black
    }

    private func fetchBackdropPhotos() {
        guard let url = NetworkService.shared.makeUrl(path: .imagePath(movieDetailData.id)) else { return }
        NetworkService.shared.fetchData(url: url) { (response: Result<MovieDetailData, Error>) in
            switch response {
            case .success(let response):
                self.backdrops = response.fiveBackdrops
                self.movieDetailView.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }

    private func fetchCast() {
        let queries: [QueryData] = [
            .language
        ]
        guard let url = NetworkService.shared.makeUrl(path: .creditPath(movieDetailData.id), queries: queries) else { return }
        NetworkService.shared.fetchData(url: url) { (response: Result<CastData, Error>) in
            switch response {
            case .success(let response):
                self.castList = response.cast
                self.movieDetailView.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }

    private func setupNavigation() {
        navigationItem.title = movieDetailData.title
        let attributeContainer = AttributeContainer([.foregroundColor: UIColor.primaryWhite])
        navigationController?.navigationBar.titleTextAttributes = .init(attributeContainer)
        let image = ImageSystem.getImage(name: ImageSystem.heart.rawValue)
        let fillImage = ImageSystem.getImage(name: ImageSystem.fillHeart.rawValue)

        if !isLiked {
            navigationItem.rightBarButtonItem = .init(image: image, style: .done, target: self, action: #selector(heartButtonTapped))
        } else {
            navigationItem.rightBarButtonItem = .init(image: fillImage, style: .done, target: self, action: #selector(heartButtonTapped))
        }
        navigationController?.navigationBar.tintColor = .primaryGreen
    }

    @objc private func heartButtonTapped(_ sender: UIButton) {
        isLiked.toggle()
        setupNavigation()
    }
}

extension MovieDetailVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let synopsisArea = 2
        let castHeader = 1
        return synopsisArea + castHeader + castList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        switch row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SynopsisCell.self), for: indexPath) as? SynopsisCell else { return .init() }
            cell.moreButton.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
            cell.selectionStyle = .none
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SynopsisLabelCell.self), for: indexPath) as? SynopsisLabelCell else { return .init() }
            cell.configureCell(data: movieDetailData, isExpended: isExpended)
            cell.selectionStyle = .none
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CastCell.self), for: indexPath) as? CastCell else { return .init() }
            cell.selectionStyle = .none
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CastListCell.self), for: indexPath) as? CastListCell else { return .init() }
            cell.configureCell(data: castList[indexPath.row - 3])
            cell.selectionStyle = .none
            return cell
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: MovieDetailHeaderView.self)) as? MovieDetailHeaderView else { return .init() }
        headerView.imageCollectionView.delegate = self
        headerView.imageCollectionView.dataSource = self
        headerView.imageCollectionView.isPagingEnabled = true
        headerView.imageCollectionView.register(MoviePhotosCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: MoviePhotosCollectionViewCell.self))

        headerView.configureView(data: movieDetailData)
        headerView.imageCollectionView.reloadData()
        headerView.pageControl.numberOfPages = backdrops.count
        self.headerView = headerView
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 250
    }

    @objc private func moreButtonTapped() {
        isExpended.toggle()
        movieDetailView.tableView.reloadData()
//        movieDetailView.tableView.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .automatic)
    }
}

extension MovieDetailVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return backdrops.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MoviePhotosCollectionViewCell.self), for: indexPath) as? MoviePhotosCollectionViewCell else { return .init() }
        cell.configureCell(data: backdrops[indexPath.row])
        return cell
    }
}

extension MovieDetailVC: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.visibleSize.width
        let currentPage = Int(scrollView.contentOffset.x / pageWidth)

        headerView?.pageControl.currentPage = currentPage
    }
}
