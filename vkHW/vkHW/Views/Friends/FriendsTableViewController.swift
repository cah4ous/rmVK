// FriendsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран списка друзей
class FriendsTableViewController: UITableViewController {
    // MARK: - Constants

    private enum Constants {
        static let friendsCellIdentifier = "friendsCell"
        static let friendsSegueIdentifier = "friendsSegue"
        static let defaultBlack = "defaultBlack"
        static let firstPersonName = "Oleg"
        static let secondPersonName = "Alex"
        static let thirdPersonName = "James"
        static let forthPersonName = "Valentin"
        static let avatarImageName = "0"
    }

    // MARK: - Public Properties

    var friends = [
        Friend(name: Constants.firstPersonName, avatarImageName: Constants.avatarImageName, likeCount: 15),
        Friend(name: Constants.secondPersonName, avatarImageName: Constants.avatarImageName, likeCount: 30),
        Friend(name: Constants.thirdPersonName, avatarImageName: Constants.avatarImageName, likeCount: 50),
        Friend(name: Constants.forthPersonName, avatarImageName: Constants.avatarImageName, likeCount: 500)
    ]

    // MARK: - Private Properties

    private var friendsSections: [Character: [Friend]] = [:]
    private var friendSectionsTitles: [Character] = []

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        initMethods()
    }

    // MARK: - Public Methods

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        String(friendSectionsTitles[section])
    }

    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let viewHeader = (view as? UITableViewHeaderFooterView) else { return }
        viewHeader.contentView.backgroundColor = UIColor(named: Constants.defaultBlack)
        viewHeader.contentView.alpha = 0.5
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        friendsSections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        friendsSections[friendSectionsTitles[section]]?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.friendsCellIdentifier,
            for: indexPath
        ) as? FriendsTableViewCell,
            let friend = friendsSections[friendSectionsTitles[indexPath.section]]?[indexPath.row]
        else { return UITableViewCell() }

        cell.configure(nameLabelText: friend.name, avatarImageName: friend.avatarImageName)
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Constants.friendsSegueIdentifier,
              let friendsCollectionViewController = segue.destination as? FriendsCollectionViewController
        else { return }
        let informationIndex = tableView.indexPathForSelectedRow?.row ?? 0
        friendsCollectionViewController.friends.append(friends[informationIndex])
    }

    // MARK: - Private Methods

    private func initMethods() {
        createFriendSections()
    }

    private func createFriendSections() {
        for friend in friends {
            guard let firstLetter = friend.name.first else { return }
            if friendsSections[firstLetter] != nil {
                friendsSections[firstLetter]?.append(friend)
            } else {
                friendsSections[firstLetter] = [friend]
            }
        }
        friendSectionsTitles = Array(friendsSections.keys).sorted()
    }
}
