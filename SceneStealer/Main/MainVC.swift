//
//  MainVC.swift
//  SceneStealer
//
//  Created by Lee on 8/1/25.
//

import UIKit

class MainVC: UIViewController {

    var userInfo: UserModel = .init(nickname: "", isOnboarding: true, registerDate: "")

    var todayMovieData: [MovieResult] = []

    var currentSearchData: [String] = []

    let mainView = MainView()

    override func loadView() {
        view = mainView
        mainView.searchCollectionView.delegate = self
        mainView.searchCollectionView.dataSource = self
        mainView.todayMovieCollectionView.delegate = self
        mainView.todayMovieCollectionView.dataSource = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setupNavigation()
        fetchData()

        guard let userData = try? UserDefaultManager.shared.loadData(key: .userInfo) ?? userInfo else { return }
        userInfo = userData

        mainView.profileBoxView.nicknameLabel.text = userInfo.nickname
        mainView.profileBoxView.dateLabel.text = userInfo.registerDate
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        guard let data: [String] = try? UserDefaultManager.shared.loadData(key: .currentSearch) else { return }
        currentSearchData = data
        mainView.searchCollectionView.reloadData()
    }

    private func configureView() {
        view.backgroundColor = .black
    }

    private func setupNavigation() {
        navigationItem.title = "SceneStealer"

        let attributeContainer = AttributeContainer([.foregroundColor: UIColor.primaryWhite])
        navigationController?.navigationBar.titleTextAttributes = .init(attributeContainer)

        let image = ImageSystem.getImage(name: ImageSystem.magnifyingglass.rawValue)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: #selector(buttonTapped))
        navigationItem.rightBarButtonItem?.tintColor = .primaryGreen

        navigationItem.backBarButtonItem = .init(title: "", style: .done, target: nil, action: nil)
    }

    private func fetchData() {
        let queries = [QueryData.page(1), QueryData.language]
        guard let url = NetworkService.shared.makeUrl(path: .trendingPath, queries: queries) else { return }
        NetworkService.shared.fetchData(url: url) { (response: Result<TodayMovieData, Error>) in
            switch response {
            case .success(let response):
                self.todayMovieData = response.results
                self.mainView.todayMovieCollectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }

    @objc private func buttonTapped() {
        print(#function)
        let vc = SearchResultVC()
        navigationItem.backBarButtonItem = .init(title: "", style: .done, target: nil, action: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case mainView.searchCollectionView:
            return currentSearchData.count
        case mainView.todayMovieCollectionView:
            return todayMovieData.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case mainView.searchCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SearchListCollectionViewCell.self), for: indexPath) as? SearchListCollectionViewCell else {
                return .init()
            }
            cell.configureSearchButton(text: currentSearchData[indexPath.row])
            return cell

        case mainView.todayMovieCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TodayMovieCollectionViewCell.self), for: indexPath) as? TodayMovieCollectionViewCell else {
                return .init()
            }
            cell.configureCell(data: todayMovieData[indexPath.row])
            return cell
        default:
            return .init()
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case mainView.searchCollectionView:
            print(#function)
        case mainView.todayMovieCollectionView:
            let movieDetailVC = MovieDetailVC()
            movieDetailVC.movieDetailData = todayMovieData[indexPath.row].movieDetailModel
            navigationController?.pushViewController(movieDetailVC, animated: true)
        default:
            return
        }
    }
}
