// DataReloadable.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Обновление ряда
protocol DataReloadable {
    func reloadRow(at indexPath: IndexPath)
}
