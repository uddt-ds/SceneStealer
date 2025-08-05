//
//  NicknameVC.swift
//  SceneStealer
//
//  Created by Lee on 8/1/25.
//

import UIKit

enum NicknameDetailVCMode {
    case onBoarding
    case setting
}

class NicknameDetailVC: UIViewController, NicknameVCProtocol {

    var delegate: NicknameDataDelegate?

    var mode: NicknameVCMode = .onBoarding

    let baseNicknameView = BaseNicknameView(isHiddenEditBtn: true)

    let checkLabel: UILabel = {
        let label = UILabel()
        label.font = .subTitleM
        label.textColor = .primaryGreen
        label.textAlignment = .left
        return label
    }()

    override func loadView() {
        view = baseNicknameView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()

        baseNicknameView.textField.delegate = self
        baseNicknameView.textField.becomeFirstResponder()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        switch mode {
        case .onBoarding:
            setupNavigation(title: "닉네임 설정")
        case .setting:
            setupNavigation(title: "닉네임 편집")
        }
    }

    func configureHierarchy() {
        [checkLabel].forEach { view.addSubview($0) }
    }

    func configureLayout() {
        let textField = baseNicknameView.textField

        checkLabel.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(20)
        }
    }

    func configureView() {
        view.backgroundColor = .primaryBlack
    }

    private func setupNavigation(title: String) {
        navigationItem.title = title
        let image = ImageSystem.getImage(name: ImageSystem.chevronL.rawValue)
        navigationItem.leftBarButtonItem = .init(image: image, style: .done, target: self, action: #selector(buttonTapped))
        let attributeContainer = AttributeContainer([.foregroundColor: UIColor.primaryWhite])
        navigationController?.navigationBar.titleTextAttributes = .init(attributeContainer)
    }

    func checkLabel(userInput: String) -> String {
        let specialSignCondition: [Character] = ["@", "#", "$", "%"]
        let numRange = Range(0...9)
        let numArr = Array<Int>(numRange)
        let strArr = numArr.map { String($0) }
        let charArr = strArr.map { Character($0) }

        if userInput.count < 2 || userInput.count > 10 {
            return NicknameLogMessage.tooShortInput.rawValue
        } else if userInput.contains(where: { specialSignCondition.contains($0) }) {
            return NicknameLogMessage.noSpecialSign.rawValue
        } else if userInput.contains(where: { charArr.contains($0)}) {
            return NicknameLogMessage.noNumber.rawValue
        } else {
            return NicknameLogMessage.validateInput.rawValue
        }
    }

    @objc private func buttonTapped() {
        if let text = baseNicknameView.textField.text {
            delegate?.dataSend(text: text)
        }

        navigationController?.popViewController(animated: true)
    }

}

extension NicknameDetailVC: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let text = textField.text, text.count > 0 {
            checkLabel.text = checkLabel(userInput: textField.text!)
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
}
