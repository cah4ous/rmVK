// Url.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Ссылка на фото
final class Url: Object, Decodable {
    /// Ссылка на фотографию
    @Persisted var url: String
    /// Ширина
    var width: Int
    /// Высота
    var height: Int
    /// Соотношение сторон
    var aspectRatio: CGFloat { CGFloat(height) / CGFloat(width) }
}
