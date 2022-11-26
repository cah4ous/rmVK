// LoadNetworkData.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation

/// Получение данных
final class NetworkCoreService {
    func loadData<T: Decodable>(urlPath: String, complition: @escaping (Result<T, Error>) -> Void) {
        AF.request(urlPath).responseJSON { response in
            guard let value = response.data else { return }
            do {
                let object = try JSONDecoder().decode(T.self, from: value)
                complition(.success(object))
            } catch {
                complition(.failure(error))
            }
        }
    }
}
