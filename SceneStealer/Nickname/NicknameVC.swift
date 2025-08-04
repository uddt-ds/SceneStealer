//
//  NicknameVC.swift
//  SceneStealer
//
//  Created by Lee on 8/1/25.
//

import UIKit

class NicknameVC: UIViewController, NicknameVCProtocol {

    let baseNicknameView = BaseNicknameView(isHiddenEditBtn: false)

    let button = PrimaryButton(title: "완료")

    override func loadView() {
        view = baseNicknameView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
        setupNavigation()

        baseNicknameView.editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
    }

    func configureHierarchy() {
        [button].forEach { view.addSubview($0) }
    }

    func configureLayout() {
        let textField = baseNicknameView.textField

        button.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(16)
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }
    }

    func configureView() {
        view.backgroundColor = .primaryBlack
    }

    private func setupNavigation() {
        navigationItem.title = "닉네임 설정"
        navigationItem.backBarButtonItem = .init(title: "", style: .done, target: nil, action: nil)
        let attributeContainer = AttributeContainer([.foregroundColor: UIColor.primaryWhite])
        navigationController?.navigationBar.titleTextAttributes = .init(attributeContainer)
    }

    @objc private func editButtonTapped() {
        let nicknameDetailVC = NicknameDetailVC()
        navigationController?.pushViewController(nicknameDetailVC, animated: true)
    }
}
