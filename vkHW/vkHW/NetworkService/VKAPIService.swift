// VKAPIService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation

/// Апи запросы
final class VKAPIService {
    // MARK: - Constants

    private enum Constants {
        static let friendsGetPathString = "/method/friends.get"
        static let getPhotosPathString = "/method/photos.getAll"
        static let getGroupsPathString = "/method/groups.get"
        static let searchGroupsByPathString = "/method/groups.search"
        static let accessTokenFieldName = "access_token"
        static let userIdFieldName = "user_id"
        static let versionFieldName = "v"
        static let queryFieldName = "q"
        static let ownerIdFieldName = "owner_id"
        static let fieldsFieldName = "fields"
        static let nicknameFieldName = "nickname"
        static let photoFieldName = "photo_100"
        static let onlineFieldName = "online"
        static let sexFieldName = "sex"
        static let accessToken = "access_token"
        static let userID = "user_id"
        static let schemaValue = "https"
        static let hostValue = "oauth.vk.com"
        static let pathValue = "/authorize"
        static let blankPathValue = "/blank.html"
        static let clientIdFieldName = "client_id"
        static let clientIdValue = "51468498"
        static let displayFieldName = "display"
        static let displayValue = "mobile"
        static let redirectUrlFieldName = "redirect_url"
        static let redirectUrlValue = "https://oauth.vk.com/blank.html"
        static let scopeFieldName = "scope"
        static let scopeValue = "262150"
        static let respondeTypeFieldName = "response_type"
        static let respondeTypeValue = "token"
        static let versionValue = "5.68"
        static let equalSign = "="
        static let appersandSign = "&"
    }

    // MARK: - Public properties

    let baseUrl = "https://api.vk.com"
    let apiVersion = "5.131"

    var apiAccessToken = ""
    var apiUserId = ""

    // MARK: - Public methods

    func loadAuthPage() -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = Constants.schemaValue
        urlComponents.host = Constants.hostValue
        urlComponents.path = Constants.pathValue
        urlComponents.queryItems = [
            URLQueryItem(name: Constants.clientIdFieldName, value: Constants.clientIdValue),
            URLQueryItem(name: Constants.displayFieldName, value: Constants.displayValue),
            URLQueryItem(name: Constants.redirectUrlFieldName, value: Constants.redirectUrlValue),
            URLQueryItem(name: Constants.scopeFieldName, value: Constants.scopeValue),
            URLQueryItem(name: Constants.respondeTypeFieldName, value: Constants.respondeTypeValue),
            URLQueryItem(name: Constants.versionFieldName, value: Constants.versionValue)
        ]
        return urlComponents.url
    }

    func loadMyFriends() {
        let path = Constants.friendsGetPathString
        let parameters: Parameters = [
            Constants.accessTokenFieldName: apiAccessToken,
            Constants.userIdFieldName: apiUserId,
            Constants.versionFieldName: apiVersion,
            Constants.fieldsFieldName: [
                Constants.photoFieldName,
                Constants.nicknameFieldName,
                Constants.onlineFieldName,
                Constants.sexFieldName
            ]
        ]
        let url = baseUrl + path
        AF.request(url, method: .post, parameters: parameters)
            .responseDecodable(of: VKAPIResponse.self) { data in
                debugPrint(data)
            }
    }

    func fetchMyPhotos() {
        let path = Constants.getPhotosPathString
        let parameters: Parameters = [
            Constants.accessTokenFieldName: apiAccessToken,
            Constants.ownerIdFieldName: apiUserId,
            Constants.versionFieldName: apiVersion
        ]
        let url = baseUrl + path
        AF.request(url, method: .post, parameters: parameters)
            .response { data in
                debugPrint(data)
            }
    }

    func fetchMyGroups() {
        let path = Constants.getGroupsPathString
        let parameters: Parameters = [
            Constants.accessTokenFieldName: apiAccessToken,
            Constants.userIdFieldName: apiUserId,
            Constants.versionFieldName: apiVersion
        ]
        let url = baseUrl + path
        AF.request(url, method: .post, parameters: parameters)
            .response { data in
                debugPrint(data)
            }
    }

    func searchMyGroups(by: String) {
        let path = Constants.searchGroupsByPathString
        let parameters: Parameters = [
            Constants.accessTokenFieldName: apiAccessToken,
            Constants.userIdFieldName: apiUserId,
            Constants.queryFieldName: by,
            Constants.versionFieldName: apiVersion
        ]

        let url = baseUrl + path
        AF.request(url, method: .post, parameters: parameters)
            .response { data in
                debugPrint(data)
            }
    }
}
