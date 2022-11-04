// FriendsCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка персональных сведений друга
final class FriendsCollectionViewCell: UICollectionViewCell {
    // MARK: - IBOutlets

    @IBOutlet var avatarPersonImageView: UIImageView!
    @IBOutlet var likeControl: LikeControl!

    // MARK: Public Methods

    func configure(imageName: String, likesCount: Int) {
        avatarPersonImageView.image = UIImage(named: imageName)
        likeControl.likeCount = likesCount
    }
}
