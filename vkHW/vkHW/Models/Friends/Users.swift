// Users.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Список пользователей
struct Users: Decodable {
    let users: [User]

    private enum CodingKeys: String, CodingKey {
        case users = "items"
    }
}
