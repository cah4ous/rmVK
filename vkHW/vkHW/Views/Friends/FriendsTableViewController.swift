// FriendsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран списка друзей
class FriendsTableViewController: UITableViewController {
    // MARK: - Constants

    private enum Constants {
        static let friendsCellIdentifier = "friendsCell"
        static let friendsSegueIdentifier = "friendsSegue"
    }

    // MARK: - Public Properties

    var friends = [
        Friend(name: "Oleg", avatarImageName: "0", likeCount: 15),
        Friend(name: "Mary", avatarImageName: "0", likeCount: 30),
        Friend(name: "Alex", avatarImageName: "0", likeCount: 50),
        Friend(name: "James", avatarImageName: "0", likeCount: 500),
        Friend(name: "Charles", avatarImageName: "0", likeCount: 23)
    ]

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        friends.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.friendsCellIdentifier,
            for: indexPath
        ) as? FriendsTableViewCell
        else { return UITableViewCell() }
        let friend = friends[indexPath.row]
        cell.configure(nameLabelText: friend.name, avatarImageName: friend.avatarImageName)
        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Constants.friendsSegueIdentifier,
              let friendsCollectionViewController = segue.destination as? FriendsCollectionViewController
        else { return }
        let informationIndex = tableView.indexPathForSelectedRow?.row ?? 0
        friendsCollectionViewController.friends.append(friends[informationIndex])
    }
}
