// ResponseGroup.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
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

/// Список групп
struct Groups: Decodable {
    let groups: [Group]

    private enum CodingKeys: String, CodingKey {
        case groups = "items"
    }
}

/// Ответ группы пользователя
struct ResponseGroups: Decodable {
    let groups: Groups

    private enum CodingKeys: String, CodingKey {
        case groups = "response"
    }
}
