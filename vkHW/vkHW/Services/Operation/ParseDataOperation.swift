// ParseDataOperation.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Парсинг данных
final class ParseDataOperation: Operation {
    // MARK: - Public Properties

    var outputData: [Group] = []

    // MARK: - Public methods

    override func main() {
        guard let getDataOperation = dependencies.first as? GetDataOperation,
              let data = getDataOperation.data else { return }
        do {
            let response = try JSONDecoder().decode(ResponseGroups.self, from: data)
            outputData = response.groups.groups
        } catch {
            print(error.localizedDescription)
        }
    }
}
