//
//  BaseNicknameView.swift
//  SceneStealer
//
//  Created by Lee on 7/31/25.
//

import UIKit
import SnapKit

class BaseNicknameView: UIView {

    let textField: UITextField = {
        let txtField = UITextField()
        txtField.font = .subTitleM
        txtField.textColor = .primaryWhite
        txtField.borderStyle = .none
        txtField.backgroundColor = .primaryBlack
        txtField.textAlignment = .left
        return txtField
    }()

    private let underLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .primaryWhite
        return view
    }()

    private let editButton: UIButton = {
        let button = UIButton()
        button.setTitle("편집", for: .normal)
        button.setTitleColor(.primaryWhite, for: .normal)
        button.titleLabel?.font = .headerTitleMB
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.primaryWhite.cgColor
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    init(isHidden: Bool = true) {
        super.init(frame: .zero)
        editButton.isHidden = isHidden
        configureHierarchy()
        configureLayout()
        configureView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func configureHierarchy() {
        [underLineView, textField, editButton].forEach { addSubview($0) }
    }

    private func configureLayout() {
        textField.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(20)
            make.directionalHorizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
            make.height.equalTo(44)
        }
    

        if editButton.isHidden {
            underLineView.snp.makeConstraints { make in
                make.top.equalTo(textField.snp.bottom)
                make.centerX.width.equalTo(textField)
                make.height.equalTo(1)
            }
        } else {
            underLineView.snp.makeConstraints { make in
                make.top.equalTo(textField.snp.bottom)
                make.leading.equalTo(textField)
                make.trailing.equalTo(textField).inset(20)
                make.height.equalTo(1)
            }
        }


        editButton.snp.makeConstraints { make in
            make.trailing.equalTo(textField.snp.trailing)
            make.bottom.equalTo(underLineView.snp.bottom)
            make.width.equalTo(70)
            make.height.equalTo(44)
        }
    }

    private func configureView() {
        backgroundColor = .primaryBlack
    }
}
