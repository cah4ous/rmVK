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

    // MARK: - Private IBOutlets

    @IBOutlet private var searchBar: UISearchBar!

    // MARK: - Private Properties

    private var searches: [Group]?
    private var groups: Results<Group>?
    private var networkService = NetworkService()
    private var notificationToken: NotificationToken?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        initMethods()
    }

    // MARK: - Private Methods

    private func initMethods() {
//        loadData()
        loadGroupsToRealm()
        createSearchBarSettings()
    }

    private func createSearchBarSettings() {
        searchBar.delegate = self
    }

    private func loadGroupsToRealm() {
        do {
            let realm = try Realm()
            let newGroups = realm.objects(Group.self)
            addNotificationToken(result: newGroups)
            if !newGroups.isEmpty {
                groups = newGroups
            } else {
                loadData()
            }
            tableView.reloadData()
        } catch {
            print(error.localizedDescription)
        }
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
            case .error:
                print("error")
            }
        }
    }

    private func loadData() {
        networkService.fetchUserGroups(userID: Session.shared.userID) { [weak self] item in
            guard let self = self else { return }
            switch item {
            case let .success(data):
//                self.groups = data.groups.groups
                self.networkService.saveDataToRealm(data.groups.groups)
            case let .failure(error):
                print(error)
            }
        }
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
//        let group = groups[indexPath.row]
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
//        groups.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}

// UISearchBarDelegate
extension GroupTableViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        searches = groups
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//        groups = searches ?? []
        tableView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        groups = searches ?? []
//        if !searchText.isEmpty {
//            groups = groups.filter { $0.name.lowercased().contains(searchText.lowercased()) }
//        }
        tableView.reloadData()
    }
}
