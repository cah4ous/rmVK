// FriendsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран списка друзей
final class FriendsTableViewController: UITableViewController {
    // MARK: - Constants

    private enum Constants {
        static let friendsCellIdentifier = "friendsCell"
        static let friendsVCIdentifier = "mainInfoFriendID"
        static let friendSegueIdentifier = "friendsSegue"
        static let defaultBlack = "defaultBlack"
        static let firstPersonName = "Oleg"
        static let secondPersonName = "Alex"
        static let thirdPersonName = "James"
        static let forthPersonName = "Valentin"
        static let avatarImageName = "0"
    }

    // MARK: - Private Properties

    private var userSectionsTitles: [Character] = []
    private var sortedUsersMap = [Character: [User]]()
    private var networkService = NetworkService()
    private var users: [User] = []

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        initMethods()
    }

    // MARK: - Public Methods

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Constants.friendSegueIdentifier,
              let allPhotosViewController = segue.destination as? FriendPhotoViewController,
              let indexPath = tableView.indexPathForSelectedRow,
              let id = getOneUser(indexPath: indexPath)?.id else { return }
        allPhotosViewController.id = "\(id)"
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        String(userSectionsTitles[section])
    }

    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let viewHeader = (view as? UITableViewHeaderFooterView) else { return }
        viewHeader.contentView.backgroundColor = UIColor(named: Constants.defaultBlack)
        viewHeader.contentView.alpha = 0.5
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        sortedUsersMap.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sortedUsersMap[userSectionsTitles[section]]?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.friendSegueIdentifier, sender: nil)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.friendsCellIdentifier,
            for: indexPath
        ) as? FriendsTableViewCell,
            let friend = sortedUsersMap[userSectionsTitles[indexPath.section]]?[indexPath.row]
        else { return UITableViewCell() }

        cell.configure(nameLabelText: friend.firstName, avatarImageName: friend.photoImageName ?? "0")
        return cell
    }

    // MARK: - Private Methods

    private func getOneUser(indexPath: IndexPath) -> User? {
        let firstChar = sortedUsersMap.keys.sorted()[indexPath.section]
        guard let users = sortedUsersMap[firstChar] else { return nil }
        let user = users[indexPath.row]
        return user
    }

    private func initMethods() {
        loadData()
    }

    private func loadData() {
        networkService.fetchFriends { [weak self] item in
            guard let self = self else { return }
            switch item {
            case let .success(data):
                self.users = data.users.users
                self.sortUsers()
                self.tableView.reloadData()
            case let .failure(error):
                print(error)
            }
        }
    }

    private func sortUsers() {
        for user in users {
            guard let firstLetter = user.firstName.first else { return }
            if sortedUsersMap[firstLetter] != nil {
                sortedUsersMap[firstLetter]?.append(user)
            } else {
                sortedUsersMap[firstLetter] = [user]
            }
        }
        userSectionsTitles = Array(sortedUsersMap.keys).sorted()
    }
}
