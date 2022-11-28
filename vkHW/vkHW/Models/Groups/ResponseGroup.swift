// ResponseGroup.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Ответ группы пользователя
struct ResponseGroups: Decodable {
    let groups: Groups

    private enum CodingKeys: String, CodingKey {
        case groups = "response"
    }
}
