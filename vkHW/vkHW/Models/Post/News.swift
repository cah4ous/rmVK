// News.swift
// Copyright © RoadMap. All rights reserved.

/// Тип поста
enum PostItemType: Decodable {
    case text
    case image
}

/// Модель поста
final class NewsFeed: Decodable {
    /// Идентификатор
    var id: Int
    /// Идентификатор группы
    var sourceId: Int
    /// Дата новости
    var date: Int
    /// Текст новости
    var text: String
    /// Имя автора
    var authorName: String?
    /// Фотография автора
    var avatarPath: String?
    /// Фотография поста
    var postImage: String?
    /// Тип поста
    var type: PostItemType?
    /// Лайки
    var likes: Likes


    enum CodingKeys: String, CodingKey {
        case id
        case sourceId = "source_id"
        case text
        case likes
        case date
        
    }
}
