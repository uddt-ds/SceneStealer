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
}


extension UserDefaultManager {
    enum UserDefaultKey: String {
        case nickname
        case isOnboarding
        case registerDate
        case likeMovies
        case currentSearch
    }
}
