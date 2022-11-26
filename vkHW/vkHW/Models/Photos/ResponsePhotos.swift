// ResponsePhotos.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Ответ все фото пользователя
struct ResponsePhotos: Decodable {
    let photos: Photos

    private enum CodingKeys: String, CodingKey {
        case photos = "response"
    }
}

/// Все фото
struct Photos: Decodable {
    let photos: [Photo]

    private enum CodingKeys: String, CodingKey {
        case photos = "items"
    }
}

/// Фото
final class Photo: Decodable {
    let urls: [Url]

    private enum CodingKeys: String, CodingKey {
        case urls = "sizes"
    }
}

/// Ссылка на фото
final class Url: Object, Decodable {
    @objc dynamic var url: String
}
