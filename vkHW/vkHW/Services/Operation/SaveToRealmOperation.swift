// SaveToRealmOperation.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Cохранения в  Realm
final class SaveToRealmOperation: Operation {
    // MARK: - Public Properties

    let realmService = RealmService()

    // MARK: - Public methods

    override func main() {
        guard let parseData = dependencies.first as? ParseDataOperation else { return }
        realmService.saveData(parseData.outputData)
    }
}
