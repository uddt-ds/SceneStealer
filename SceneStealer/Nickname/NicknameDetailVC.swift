//
//  NicknameVC.swift
//  SceneStealer
//
//  Created by Lee on 8/1/25.
//

import UIKit

class NicknameDetailVC: UIViewController, NicknameVCProtocol {

    let baseNicknameView = BaseNicknameView(isHiddenEditBtn: true)

    let checkLabel: UILabel = {
        let label = UILabel()
        label.text = "테스트"
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
}
