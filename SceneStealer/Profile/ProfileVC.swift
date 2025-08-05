//
//  SettingVC.swift
//  SceneStealer
//
//  Created by Lee on 8/3/25.
//

import UIKit

class ProfileVC: UIViewController {

    let profileView = ProfileView()

    var userInfo: UserModel = .init(nickname: "", isOnboarding: true, registerDate: "")

    override func loadView() {
        view = profileView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setupNavigation()

        profileView.tableView.dataSource = self
        profileView.tableView.delegate = self

        loadProfileData()
    }

    private func configureView() {
        view.backgroundColor = .black
    }


    private func setupNavigation() {
        navigationItem.title = "설정"

        let attributeContainer = AttributeContainer([.foregroundColor: UIColor.primaryWhite])
        navigationController?.navigationBar.titleTextAttributes = .init(attributeContainer)
    }

    private func loadProfileData() {
        guard let userData = try? UserDefaultManager.shared.loadData(key: .userInfo) ?? userInfo else { return }
        userInfo = userData

        profileView.profileBoxView.nicknameLabel.text = userInfo.nickname
        profileView.profileBoxView.dateLabel.text = userInfo.registerDate
        setupProfileButton()
    }

    private func setupProfileButton() {
        profileView.profileBoxView.setDetailButton.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
    }

    //TODO: 이쪽 로직 수정 필요
    @objc private func profileButtonTapped() {
        let vc = NicknameVC()
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .pageSheet
        let image = ImageSystem.getImage(name: ImageSystem.xmark.rawValue)
//        navVC.navigationItem.leftBarButtonItem = .init(image: image, style: .done, target: self, action: #selector(closeButtonTapped))
        navVC.navigationBar.tintColor = .primaryGreen
        navVC.navigationItem.title = "닉네임 편집"
        present(navVC, animated: true)
    }
}

extension ProfileVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProfileMenuTitle.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProfileTableViewCell.self), for: indexPath) as? ProfileTableViewCell else { return .init() }
        cell.configureCell(data: ProfileMenuTitle.allCases[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 3 {
            showAlert(title: "탈퇴하기", message: "탈퇴를 하면 데이터가 모두 초기화됩니다. 탈퇴하시겠습니까?") { _ in
                UserDefaultManager.shared.removeData(key: .userInfo)
                UserDefaultManager.shared.removeData(key: .currentSearch)
                UserDefaultManager.shared.removeData(key: .likeMovies)
                let onBoardingVC = OnboardingVC()
                let navOnboardingVC = UINavigationController(rootViewController: onBoardingVC)
                self.view.window?.rootViewController = navOnboardingVC
            }
        }
    }
}
