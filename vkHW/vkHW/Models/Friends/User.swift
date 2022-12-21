// User.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Пользователь
final class User: Object, Decodable {
    /// Идентификатор
    @Persisted(primaryKey: true) var id: Int
    /// Имя
    @Persisted var firstName: String
    /// Фамилия
    @Persisted var lastName: String
    /// Размер фото
    @Persisted var photoImageName: String?

    private enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case photoImageName = "photo_100"
    }
}
