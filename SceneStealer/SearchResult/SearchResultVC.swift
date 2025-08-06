//
//  SearchResultVC.swift
//  SceneStealer
//
//  Created by Lee on 8/2/25.
//

import UIKit

class SearchResultVC: UIViewController {

    var keyword: String = ""
    var page: Int = 1
    var searchData: [SearchData] = []

    var likeModel = LikeModel()

    var searchTotalData: SearchMovieData = .init(results: [], totalPages: 1, totalPagesResult: 1)

    let searchResultView = SearchResultView()

    override func loadView() {
        view = searchResultView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        searchResultView.searchBar.delegate = self
        searchResultView.tableView.dataSource = self
        searchResultView.tableView.delegate = self
        searchResultView.tableView.register(SearchResultTableViewCell.self, forCellReuseIdentifier: SearchResultTableViewCell.identifier)
        configureView()
        setupNavigation()

        if let savedLikeModel: LikeModel = try? UserDefaultManager.shared.loadData(key: .likeMovies) {
            likeModel = savedLikeModel
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if keyword != "" {
            fetchSearchResult(page: page)
            searchResultView.searchBar.text = keyword
        }
    }

    func configureView() {
        searchResultView.tableView.backgroundColor = .primaryBlack
        view.backgroundColor = .primaryBlack
    }

    private func setupNavigation() {
        navigationItem.title = "영화 검색"
        let attributeContainer = AttributeContainer([.foregroundColor: UIColor.primaryWhite])
        navigationController?.navigationBar.tintColor = .primaryGreen
        navigationController?.navigationBar.titleTextAttributes = .init(attributeContainer)
    }

    private func fetchSearchResult(page: Int) {
        let queries: [QueryData] = [
            .page(page),
            .language,
            .includeAdult,
            .query(keyword)
        ]

        guard let url = NetworkService.shared.makeUrl(path: .searchPath, queries: queries) else { return }
        NetworkService.shared.fetchData(url: url) { (response: Result<SearchMovieData, Error>) in
            switch response {
            case .success(let responseData):
                if responseData.results.isEmpty && self.page == 1 {
                    self.searchData.removeAll()
                    self.searchResultView.tableView.reloadData()
                    self.searchResultView.label.isHidden = false
                    return
                }

                self.searchTotalData = responseData
                self.searchData.append(contentsOf: responseData.results)
                self.searchResultView.tableView.reloadData()
                self.searchResultView.label.isHidden = true

            case .failure(let error):
                if page == 1 {
                    self.searchData.removeAll()
                    self.searchResultView.label.isHidden = false
                    self.searchResultView.tableView.reloadData()
                    print(error)
                }
            }
        }
    }
}

extension SearchResultVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultTableViewCell.identifier, for: indexPath) as? SearchResultTableViewCell else { return .init() }

        if let likeMoviesData: LikeModel = try? UserDefaultManager.shared.loadData(key: .likeMovies) {
            let isLiked = likeMoviesData.isLike(movieId: searchData[indexPath.row].id)
            cell.configureCell(data: searchData[indexPath.row], isLiked: isLiked)
        }

        cell.selectionStyle = .none
        cell.heartButton.tag = indexPath.row
        cell.heartButton.addTarget(self, action: #selector(heartButtonTapped), for: .touchUpInside)
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (searchData.count - 3) && searchTotalData.totalPages > page {
            page += 1
            fetchSearchResult(page: page)
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MovieDetailVC()
        vc.movieDetailData = searchData[indexPath.row].movieDetailData
        navigationItem.title = ""
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc private func heartButtonTapped(_ sender: UIButton) {
        likeModel.updateLikeMovie(movieId: searchData[sender.tag].id)
        searchResultView.tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .automatic)
    }
}

extension SearchResultVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text, text.count > 0 {
            keyword = text

            UserDefaultManager.shared.updateData(key: .currentSearch, value: text)
        }

        fetchSearchResult(page: page)
        view.endEditing(true)
    }
}
