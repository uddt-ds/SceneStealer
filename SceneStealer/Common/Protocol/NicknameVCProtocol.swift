//
//  NicknameVCProtocol.swift
//  SceneStealer
//
//  Created by Lee on 8/1/25.
//

import Foundation

protocol NicknameVCProtocol {
    var baseNicknameView: BaseNicknameView { get }

    func configureHierarchy()
    func configureLayout()
    func configureView()
}
