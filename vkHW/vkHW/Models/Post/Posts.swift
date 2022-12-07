// Posts.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Список новостей
struct Posts: Decodable {
    let news: [NewsFeed]
    let groups: [Group]
    let friends: [User]

    enum CodingKeys: String, CodingKey {
        case news = "items"
        case friends = "profiles"
        case groups
    }
}
