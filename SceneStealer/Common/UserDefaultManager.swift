//
//  UserDefaultManager.swift
//  SceneStealer
//
//  Created by Lee on 8/4/25.
//

import Foundation

struct UserDefaultManager {
    static let shared = UserDefaultManager()

    private let userDefaults = UserDefaults.standard

    private init() { }

    func loadData<T: Decodable>(key: UserDefaultManager.UserDefaultKey) throws -> T {
        guard let data = userDefaults.data(forKey: key.rawValue) else {
            print("데이터 불러오기 실패")
            throw UserDefaultsError.failDataFetch
        }
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            throw UserDefaultsError.failDecoding
        }
    }

    func saveData<T: Encodable>(key: UserDefaultManager.UserDefaultKey, value: T) {
        if let encodedData = try? JSONEncoder().encode(value) {
            userDefaults.set(encodedData, forKey: key.rawValue)
        }
    }

    func updateData<T: Codable>(key: UserDefaultManager.UserDefaultKey, value: T) {
        var currentData: [T] = (try? loadData(key: key)) ?? []
        currentData.insert(value, at: 0)
        saveData(key: key, value: currentData)
    }

    func removeData<T: Codable>(key: UserDefaultManager.UserDefaultKey, value: T) {
        var currentData: [T] = (try? loadData(key: .userInfo)) ?? []
        currentData.removeAll()
        saveData(key: key, value: currentData)
    }
}


extension UserDefaultManager {
    enum UserDefaultKey: String {
        case userInfo
        case nickname
        case isOnboarding
        case registerDate
        case likeMovies
        case currentSearch
    }
}
