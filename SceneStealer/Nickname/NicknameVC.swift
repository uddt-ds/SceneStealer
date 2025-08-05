//
//  NicknameVC.swift
//  SceneStealer
//
//  Created by Lee on 8/1/25.
//

import UIKit
import Toast

enum NicknameVCMode {
    case onBoarding
    case setting
}

class NicknameVC: UIViewController, NicknameVCProtocol {

    var mode: NicknameVCMode = .onBoarding

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
        baseNicknameView.editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        switch mode {
        case .onBoarding:
            navigationItem.leftBarButtonItem = nil
            setupNavigation(title: "닉네임 설정")
        case .setting:
            let image = ImageSystem.getImage(name: ImageSystem.xmark.rawValue)
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: #selector(closeButtonTapped))
            setupNavigation(title: "닉네임 편집")
        }
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

    private func setupNavigation(title: String) {
        navigationItem.title = title
        navigationItem.backBarButtonItem = .init(title: "", style: .done, target: nil, action: nil)
        let attributeContainer = AttributeContainer([.foregroundColor: UIColor.primaryWhite])
        navigationController?.navigationBar.titleTextAttributes = .init(attributeContainer)
    }

    @objc private func editButtonTapped() {
        let nicknameDetailVC = NicknameDetailVC()
        nicknameDetailVC.delegate = self

        if let text = baseNicknameView.textField.text, text.count > 0 {
            nicknameDetailVC.baseNicknameView.textField.text = text
        }

        switch mode {
        case .onBoarding:
            nicknameDetailVC.mode = .onBoarding
        case .setting:
            nicknameDetailVC.mode = .setting
        }

        navigationController?.pushViewController(nicknameDetailVC, animated: true)

    }

    @objc private func buttonTapped() {
        switch mode {
        case .onBoarding:
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
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "YY.MM.dd"
                    let date = dateFormatter.string(from: Date())
                    UserDefaultManager.shared.saveData(key: .userInfo, value: UserModel(nickname: userInput, isOnboarding: true, registerDate: "\(date) 가입"))
                    let tabBarController = TabBarController()
                    view.window?.rootViewController = tabBarController
                }
            }
        case .setting:
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
                    guard let date: UserModel = try? UserDefaultManager.shared.loadData(key: .userInfo) else { return }
                    UserDefaultManager.shared.saveData(key: .userInfo, value: UserModel(nickname: userInput, isOnboarding: true, registerDate: date.registerDate))
                    let tabBarController = TabBarController()
                    view.window?.rootViewController = tabBarController
                }
            }
        }

    }

    @objc private func closeButtonTapped() {
        dismiss(animated: true)
    }
}

extension NicknameVC: NicknameDataDelegate {
    func dataSend(text: String) {
        baseNicknameView.textField.text = text
    }
}
