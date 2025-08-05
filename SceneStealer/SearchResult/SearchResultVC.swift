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
        searchResultView.tableView.register(SearchResultTableViewCell.self, forCellReuseIdentifier: String(describing: SearchResultTableViewCell.self))
        configureView()
        setupNavigation()
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SearchResultTableViewCell.self), for: indexPath) as? SearchResultTableViewCell else { return .init() }
        cell.configureCell(data: searchData[indexPath.row])
        cell.selectionStyle = .none
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
