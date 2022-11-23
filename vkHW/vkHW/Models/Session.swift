// Session.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Сохранение информации о юзере
final class Session {
    
    // MARK: - Public Properties
    
    static let shared = Session()
    var userId = ""
    var token = ""

    // MARK: - Initializers
    private init() {}
}
