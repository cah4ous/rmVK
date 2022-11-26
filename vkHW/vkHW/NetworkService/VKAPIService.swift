// VKAPIService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation

/// Апи запросы
final class VKAPIService {
    // MARK: - Private Constants

    private enum Constants {
        static let groupSearchParam = "Football"
        static let userID = "109010578"
    }

    // MARK: - Public Properties

    private let core = NetworkCoreService()

    var users: [User] = []

    // MARK: - Public methods

    func fetchFriends(complition: @escaping (Result<ResponseUsers, Error>) -> Void) {
        core.loadData(urlPath: NetworkRequests.friends.urlPath, complition: complition)
    }

    func fetchUserPhotos(userID: String, complition: @escaping (Result<ResponsePhotos, Error>) -> Void) {
        core.loadData(urlPath: NetworkRequests.photos(userID: userID).urlPath, complition: complition)
    }

    func fetchUserGroups(userID: String, complition: @escaping (Result<ResponseGroups, Error>) -> Void) {
        core.loadData(urlPath: NetworkRequests.groups(userID: userID).urlPath, complition: complition)
    }
}
