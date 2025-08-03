//
//  SettingMenuTitle 2.swift
//  SceneStealer
//
//  Created by Lee on 8/3/25.
//


import Foundation

enum ProfileMenuTitle: Int, CaseIterable {
    case frequentQuestion
    case oneToOne
    case notificationSetting
    case resign

    var title: String {
        switch self {
        case .frequentQuestion: return "자주 묻는 질문"
        case .oneToOne: return "1:1 문의"
        case .notificationSetting: return "알림 설정"
        case .resign: return "탈퇴하기"
        }
    }
}
