// Response.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// ответ от ВК
struct VKAPIResponse: Codable {
    let response: VKResponse
}

/// ВК респонс
struct VKResponse: Codable {
    let count: Int
    let items: [VKFriend]
}
