// Group.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Группа
final class Group: Object, Decodable {
    /// Название группы и идентификатор
    @Persisted(primaryKey: true) var name: String
    /// Размер фотографии
    @Persisted var photoImageName: String?

    private enum CodingKeys: String, CodingKey {
        case name
        case photoImageName = "photo_100"
    }
}
