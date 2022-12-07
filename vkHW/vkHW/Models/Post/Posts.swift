// Posts.swift
// Copyright © RoadMap. All rights reserved.

/// Список новостей
struct Posts: Decodable {
    /// Новости
    let news: [NewsFeed]
    /// Группы
    let groups: [Group]
    /// Пользователи
    let friends: [User]

    enum CodingKeys: String, CodingKey {
        case news = "items"
        case friends = "profiles"
        case groups
    }
}
