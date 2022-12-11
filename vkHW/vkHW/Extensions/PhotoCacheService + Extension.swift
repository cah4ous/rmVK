// PhotoCacheService + Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Хранение в контейнере DataReloadable классы таблиц
extension PhotoCacheService {
    class TableViewController: DataReloadable {
        let table: UITableViewController

        init(table: UITableViewController) {
            self.table = table
        }

        func reloadRow(at indexPath: IndexPath) {
            table.tableView.reloadRows(at: [indexPath], with: .none)
        }
    }

    class Table: DataReloadable {
        let table: UITableView

        init(table: UITableView) {
            self.table = table
        }

        func reloadRow(at indexPath: IndexPath) {
            table.reloadRows(at: [indexPath], with: .none)
        }
    }
}
