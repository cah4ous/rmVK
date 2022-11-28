// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation

/// Апи запросы
final class NetworkService {
    // MARK: - Private Constants

    private enum Constants {
        static let groupSearchParam = "Football"
        static let userID = "109010578"
    }

    // MARK: - Public Properties

    var users: [User] = []

    // MARK: - Private Methods

    private func loadData<T: Decodable>(urlPath: String, completion: @escaping (Result<T, Error>) -> Void) {
        AF.request(urlPath).responseJSON { response in
            guard let value = response.data else { return }
            do {
                let object = try JSONDecoder().decode(T.self, from: value)
                completion(.success(object))
            } catch {
                completion(.failure(error))
            }
        }
    }

    // MARK: - Public methods

    func fetchFriends(complition: @escaping (Result<ResponseUsers, Error>) -> Void) {
        loadData(urlPath: NetworkRequests.friends.urlPath, completion: complition)
    }

    func fetchUserPhotos(userID: String, complition: @escaping (Result<ResponsePhotos, Error>) -> Void) {
        loadData(urlPath: NetworkRequests.photos(userID: userID).urlPath, completion: complition)
    }

    func fetchUserGroups(userID: String, complition: @escaping (Result<ResponseGroups, Error>) -> Void) {
        loadData(urlPath: NetworkRequests.groups(userID: userID).urlPath, completion: complition)
    }

    func downloadImage(url: String) -> Data? {
        guard let url = URL(string: url),
              let data = try? Data(contentsOf: url)
        else { return nil }
        return data
    }
}
