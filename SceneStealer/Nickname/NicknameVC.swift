//
//  NicknameVC.swift
//  SceneStealer
//
//  Created by Lee on 8/1/25.
//

import UIKit
import Toast

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
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
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

        baseNicknameView.textField.isUserInteractionEnabled = false
    }

    private func setupNavigation() {
        navigationItem.title = "닉네임 설정"
        navigationItem.backBarButtonItem = .init(title: "", style: .done, target: nil, action: nil)
        let attributeContainer = AttributeContainer([.foregroundColor: UIColor.primaryWhite])
        navigationController?.navigationBar.titleTextAttributes = .init(attributeContainer)
    }

    @objc private func editButtonTapped() {
        let nicknameDetailVC = NicknameDetailVC()
        nicknameDetailVC.delegate = self
        navigationController?.pushViewController(nicknameDetailVC, animated: true)
    }

    @objc private func buttonTapped() {
        let specialSignCondition: [Character] = ["@", "#", "$", "%"]
        let numRange = Range(0...9)
        let numArr = Array<Int>(numRange)
        let strArr = numArr.map { String($0) }
        let charArr = strArr.map { Character($0) }

        if let userInput = baseNicknameView.textField.text, userInput.count > 0 {
            if userInput.count < 2 || userInput.count > 10 {
                view.makeToast(NicknameLogMessage.tooShortInput.rawValue, duration: 2.0, position: .bottom)
            } else if userInput.contains(where: { specialSignCondition.contains($0) }) {
                view.makeToast(NicknameLogMessage.noSpecialSign.rawValue, duration: 2.0, position: .bottom)
            } else if userInput.contains(where: { charArr.contains($0)}) {
                view.makeToast(NicknameLogMessage.noNumber.rawValue, duration: 2.0, position: .bottom)
            } else {
                let tabBarController = TabBarController()
                view.window?.rootViewController = tabBarController
            }
        }
    }
}

extension NicknameVC: NicknameDataDelegate {
    func dataSend(text: String) {
        baseNicknameView.textField.text = text
    }
}
