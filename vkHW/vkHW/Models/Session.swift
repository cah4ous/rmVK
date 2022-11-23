// Session.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Сессия
class Session {
    var userId = ""
    var token = ""
    static let shared = Session()

    private init() {}
}
