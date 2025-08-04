//
//  MainVC.swift
//  SceneStealer
//
//  Created by Lee on 8/1/25.
//

import UIKit

class MainVC: UIViewController {

    var todayMovieData: [MovieResult] = []

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
    }

    private func configureView() {
        view.backgroundColor = .black
    }

    private func setupNavigation() {
        navigationItem.title = "SceneStealer"

        let attributeContainer = AttributeContainer([.foregroundColor: UIColor.primaryWhite])
        navigationController?.navigationBar.titleTextAttributes = .init(attributeContainer)

        let image = ImageSystem.getImage(name: ImageSystem.magnifyingglass.rawValue)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .done, target: nil, action: #selector(buttonTapped))
        navigationItem.rightBarButtonItem?.tintColor = .primaryGreen
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
    }
}

extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return todayMovieData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case mainView.searchCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SearchListCollectionViewCell.self), for: indexPath) as? SearchListCollectionViewCell else {
                return .init()
            }
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
}
