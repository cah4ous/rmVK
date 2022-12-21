// Photo.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift
/// Фото
final class Photo: Object, Decodable {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var urls = List<Url>()
    @Persisted var ownerId: Int

    private enum CodingKeys: String, CodingKey {
        case urls = "sizes"
        case ownerId = "owner_id"
        case id
    }
}
