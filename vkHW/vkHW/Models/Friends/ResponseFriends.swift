// ResponseFriends.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Ответ пользователи
struct ResponseUsers: Decodable {
    let users: Users

    private enum CodingKeys: String, CodingKey {
        case users = "response"
    }
}

/// Список пользователей
struct Users: Decodable {
    let users: [User]

    private enum CodingKeys: String, CodingKey {
        case users = "items"
    }
}

/// Пользователь
final class User: Object, Decodable {
    @objc dynamic var id: Int
    @objc dynamic var firstName: String
    @objc dynamic var lastName: String
    @objc dynamic var photoImageName: String?

    private enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case photoImageName = "photo_100"
    }
}
