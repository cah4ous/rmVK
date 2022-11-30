// RealmService.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// База данных
final class RealmService {
    // MARK: - Public Methods

    func saveDataToRealm<T: Object>(_ data: [T]) {
        do {
            let configuration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
            let realm = try Realm(configuration: configuration)
            try realm.write {
                realm.add(data, update: .modified)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
