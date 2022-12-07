// News.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Тип поста
enum PostItemType: Decodable {
    case text
    case image
}

/// Модель поста
final class NewsFeed: Decodable {
    var id: Int
    var sourceId: Int
    var date: Int
    var text: String
    var authorName: String?
    var avatarPath: String?
    var postImage: String?
    var type: PostItemType?
    var likes: Likes

    enum CodingKeys: String, CodingKey {
        case id
        case sourceId = "source_id"
        case text
        case likes
        case date
    }

    enum PostItemType {
        case text
        case image
    }
}
