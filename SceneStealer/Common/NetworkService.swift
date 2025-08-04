//
//  NetworkService.swift
//  SceneStealer
//
//  Created by Lee on 8/4/25.
//

import Foundation
import Alamofire

struct NetworkService {

    static let shared = NetworkService()

    private init() { }

    func makeUrl(path: APIData, queries: [QueryData]) -> URL? {
        var components = URLComponents()
        components.scheme = APIData.scheme.getUrlComponents
        components.host = APIData.host.getUrlComponents
        components.path = path.getUrlComponents
        components.queryItems = queries.map{ $0.getQuery }
        return components.url
    }

    func fetchData<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        guard let headers = HeaderData.header else { return }
        AF.request(url, headers: headers)
            .responseDecodable(of: T.self) { responseData in
                guard let statusCode = responseData.response?.statusCode else {
                    completion(.failure(NetworkError.invalidURL))
                    return
                }
                switch statusCode {
                case 200..<300:
                    switch responseData.result {
                    case .success(let data):
                        completion(.success(data))
                    case .failure(let error):
                        completion(.failure(NetworkError.failDecoding))
                    }
                case 400..<500:
                    completion(.failure(NetworkError.serverError))
                default:
                    completion(.failure(NetworkError.unKnownError))
                }
            }
    }
}
