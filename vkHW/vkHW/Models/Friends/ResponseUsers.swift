// ResponseUsers.swift
// Copyright © RoadMap. All rights reserved.

/// Ответ пользователи
struct ResponseUsers: Decodable {
    let users: Users

    private enum CodingKeys: String, CodingKey {
        case users = "response"
    }
}
