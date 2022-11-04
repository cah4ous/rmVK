// FriendsCollectionViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран информации о друге
final class FriendsCollectionViewController: UICollectionViewController {
    // MARK: - Constants

    private enum Constants {
        static let friendCollectionViewCellIdentifier = "friendsCollectionCell"
    }

    // MARK: - Public Properties

    var friends: [Friend] = []

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        friends.count
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.friendCollectionViewCellIdentifier,
            for: indexPath
        ) as? FriendsCollectionViewCell
        else { return FriendsCollectionViewCell() }
        cell.configure(
            imageName: friends[indexPath.row].avatarImageName,
            likesCount: friends[indexPath.row].likeCount
        )
        return cell
    }
}
