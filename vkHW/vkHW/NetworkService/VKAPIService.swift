// VKAPIService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation

/// Апи запросы
struct VKAPIService: LoadNetworkDataProtocol {
    // MARK: - Private Constants

    private enum Constants {
        static let groupSearchParam = "Football"
    }

    // MARK: - Public methods

    func printAllData() {
        fetchFriends()
        fetchUserPhotos(for: Session.shared.userID)
        fetchUserGroups(for: Session.shared.userID)
        fetchPublicGroups()
    }

    // MARK: - Private methods

    private func fetchFriends() {
        loadData(urlPath: NetworkRequests.friends.urlPath)
    }

    private func fetchUserPhotos(for userID: String) {
        loadData(urlPath: NetworkRequests.photos(userID: userID).urlPath)
    }

    private func fetchUserGroups(for userID: String) {
        loadData(urlPath: NetworkRequests.groups(userID: userID).urlPath)
    }

    private func fetchPublicGroups() {
        loadData(urlPath: NetworkRequests.globalGroups(query: Constants.groupSearchParam).urlPath)
    }
}
