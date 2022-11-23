// VKFriend.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Друг из ВК
struct VKFriend: Codable {
    let id: Int
    let photoThumb: String
    let online: Int
    let firstName: String
    let lastName: String
    let sex: Int

    enum CodingKeys: String, CodingKey {
        case id, online, sex
        case photoThumb = "photo_100"
        case firstName = "first_name"
        case lastName = "last_name"
    }
}
