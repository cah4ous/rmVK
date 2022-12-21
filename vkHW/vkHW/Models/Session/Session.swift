// Session.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Информация о сессии юзера
final class Session {
    // MARK: - Public Properties

    static let shared = Session()
    var userID = ""
    var token = ""

    // MARK: - Initializers

    private init() {}
}
