// GroupTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран групп
final class GroupTableViewController: UITableViewController {
    // MARK: - Constants

    private enum Constants {
        static let groupCellIdentifier = "groupCell"
    }

    // MARK: - Public Properties

    var groups: [Group] = [
        Group(name: "The swift developers", imageName: "0"),
        Group(name: "not The swift developers", imageName: "0"),
        Group(name: "The swift developers", imageName: "0")
    ]

    // MARK: - Lifeсycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        groups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.groupCellIdentifier,
            for: indexPath
        ) as? GroupTableViewCell
        else { return UITableViewCell() }
        let group = groups[indexPath.row]
        cell.configure(nameLabelText: group.name, groupsImageName: group.imageName)
        return cell
    }

    override func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        guard editingStyle == .delete else { return }
        groups.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
}
