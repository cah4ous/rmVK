// Posts.swift
// Copyright © RoadMap. All rights reserved.

/// Список новостей
struct Posts: Decodable {
    /// Новости
    let newsFeeds: [NewsFeed]
    /// Группы
    let groups: [Group]
    /// Пользователи
    let users: [User]

    enum CodingKeys: String, CodingKey {
        case newsFeeds = "items"
        case users = "profiles"
        case groups
    }
}
