//
//  NetworkError.swift
//  SceneStealer
//
//  Created by Lee on 8/4/25.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case failDecoding
    case serverError
    case noData
    case unKnownError
}
