// GroupTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift
import UIKit

/// Экран групп
final class GroupTableViewController: UITableViewController {
    // MARK: - Constants

    private enum Constants {
        static let groupCellIdentifier = "groupCell"
        static let groupNameText = "The swift developers"
        static let otherGroupNameText = "not The swift developers"
        static let groupImageNameText = "0"
    }

    // MARK: - Private Properties

    private var groups: Results<Group>?
    private var networkService = NetworkService()
    private var realmService = RealmService()
    private var notificationToken: NotificationToken?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        initMethods()
    }

    // MARK: - Private Methods

    private func initMethods() {
        loadData()
    }

    private func loadData() {
        guard let newGroups = RealmService.defaultRealmService.readData(type: Group.self)
        else { return }
        addNotificationToken(result: newGroups)
        operationGroups()
        groups = newGroups
    }

    private func addNotificationToken(result: Results<Group>) {
        notificationToken = result.observe { [weak self] changes in
            guard let self = self else { return }
            switch changes {
            case .initial:
                break
            case .update:
                self.groups = result
                self.tableView.reloadData()
            case let .error(error):
                print(error.localizedDescription)
            }
        }
    }

    private func operationGroups() {
        networkService.fetchGroups()
    }

    // MARK: - Public Methods

    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        groups?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let group = groups?[indexPath.row],
              let cell = tableView.dequeueReusableCell(
                  withIdentifier: Constants.groupCellIdentifier,
                  for: indexPath
              ) as? GroupTableViewCell
        else { return UITableViewCell() }
        cell.configure(
            nameLabelText: group.name,
            groupsImageName: group.photoImageName ?? "0",
            networkService: networkService
        )
        return cell
    }

    override func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        guard editingStyle == .delete else { return }
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}
