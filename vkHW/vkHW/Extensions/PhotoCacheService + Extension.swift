// PhotoCacheService + Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Хранение в контейнере DataReloadable классы таблиц
extension PhotoCacheService {
    class TableViewController: DataReloadable {
        let tableViewController: UITableViewController

        init(tableViewController: UITableViewController) {
            self.tableViewController = tableViewController
        }

        func reloadRow(at indexPath: IndexPath) {
            tableViewController.tableView.reloadRows(at: [indexPath], with: .none)
        }
    }

    class Table: DataReloadable {
        let tableView: UITableView

        init(tableView: UITableView) {
            self.tableView = tableView
        }

        func reloadRow(at indexPath: IndexPath) {
            tableView.reloadRows(at: [indexPath], with: .none)
        }
    }
}
