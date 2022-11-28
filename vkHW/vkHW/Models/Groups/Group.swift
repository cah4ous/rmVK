// Group.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Группа
final class Group: Object, Decodable {
    @objc dynamic var name: String
    @objc dynamic var photoImageName: String?

    private enum CodingKeys: String, CodingKey {
        case name
        case photoImageName = "photo_100"
    }
}
