// NewsCellProtocol.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Псевдоним для конфигурирования ячеек
typealias NewsCell = UITableViewCell & NewsCellConfigurable

/// Конфигурация ячеек
protocol NewsCellConfigurable {
    func configure(_ news: NewsFeed, photoCacheService: PhotoCacheService)
}
