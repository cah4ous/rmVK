// Group.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Группа
final class Group: Object, Decodable {
    /// Идентификатор
    @Persisted(primaryKey: true) var id: Int
    /// Название группы
    @Persisted var name: String
    /// Фотография
    @Persisted var photoImageName: String?

    private enum CodingKeys: String, CodingKey {
        case name
        case id
        case photoImageName = "photo_100"
    }
}
