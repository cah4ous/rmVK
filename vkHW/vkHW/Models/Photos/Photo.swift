// Photo.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Фото
final class Photo: Decodable {
    let urls: [Url]

    private enum CodingKeys: String, CodingKey {
        case urls = "sizes"
    }
}
