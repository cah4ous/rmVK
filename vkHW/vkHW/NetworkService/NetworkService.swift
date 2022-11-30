// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation
import Realm
import RealmSwift

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
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
    }

    // MARK: - Public methods

    func fetchFriends(completion: @escaping (Result<ResponseUsers, Error>) -> Void) {
        loadData(urlPath: NetworkRequests.friends.urlPath, completion: completion)
    }

    func fetchUserPhotos(userID: String, completion: @escaping (Result<ResponsePhotos, Error>) -> Void) {
        loadData(urlPath: NetworkRequests.photos(userID: userID).urlPath, completion: completion)
    }

    func fetchUserGroups(userID: String, completion: @escaping (Result<ResponseGroups, Error>) -> Void) {
        loadData(urlPath: NetworkRequests.groups(userID: userID).urlPath, completion: completion)
    }

    func downloadImage(url: String) -> Data? {
        guard let url = URL(string: url),
              let data = try? Data(contentsOf: url)
        else { return nil }
        return data
    }

    func saveDataToRealm<T: Object>(_ data: [T]) {
        do {
//            let configuration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
            let realm = try Realm()
            try realm.write {
                realm.add(data, update: .modified)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
