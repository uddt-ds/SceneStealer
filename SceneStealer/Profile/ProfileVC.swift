//
//  SettingVC.swift
//  SceneStealer
//
//  Created by Lee on 8/3/25.
//

import UIKit

class ProfileVC: UIViewController {

    let profileView = ProfileView()

    override func loadView() {
        view = profileView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setupNavigation()

        profileView.tableView.dataSource = self
        profileView.tableView.delegate = self
    }

    private func configureView() {
        view.backgroundColor = .black
    }


    private func setupNavigation() {
        navigationItem.title = "설정"

        let attributeContainer = AttributeContainer([.foregroundColor: UIColor.primaryWhite])
        navigationController?.navigationBar.titleTextAttributes = .init(attributeContainer)
    }

}

extension ProfileVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProfileMenuTitle.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProfileTableViewCell.self), for: indexPath) as? ProfileTableViewCell else { return .init() }
        return cell
    }
}
