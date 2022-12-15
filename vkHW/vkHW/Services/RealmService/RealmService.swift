// RealmService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Сервис для работы с объектами Realm
final class RealmService {
    // MARK: - Public Properties

    static let defaultRealmService = RealmService()

    // MARK: - Private Properties

    private let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)

    // MARK: - Public Methods

    func readData<T: Object>(type: T.Type) -> Results<T>? {
        var items: Results<T>?
        do {
            let realm = try Realm()
            items = realm.objects(type)
        } catch {
            print(error.localizedDescription)
        }
        return items
    }

    func saveData<T: Object>(_ newItems: [T]) {
        do {
            let realm = try Realm()
            let oldItems = realm.objects(T.self)
            realm.beginWrite()
            realm.add(newItems, update: .modified)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
}
