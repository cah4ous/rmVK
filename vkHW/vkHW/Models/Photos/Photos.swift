// Photos.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Все фото
struct Photos: Decodable {
    let photos: [Photo]

    private enum CodingKeys: String, CodingKey {
        case photos = "items"
    }
}
