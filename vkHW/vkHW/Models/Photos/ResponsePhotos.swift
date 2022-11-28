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
