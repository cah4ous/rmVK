// Url.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Ссылка на фото
final class Url: Object, Decodable {
    /// Ссылка на фотографию
    @Persisted var url: String
}
