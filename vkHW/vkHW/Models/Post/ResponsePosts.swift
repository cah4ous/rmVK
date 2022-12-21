// ResponsePosts.swift
// Copyright © RoadMap. All rights reserved.

/// Ответ постов
struct ResponsePosts: Decodable {
    let posts: Posts

    private enum CodingKeys: String, CodingKey {
        case posts = "response"
    }
}
