// FriendsCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка персональных сведений друга
final class FriendsCollectionViewCell: UICollectionViewCell {
    // MARK: - Private IBOutlets

    @IBOutlet private var avatarPersonImageView: UIImageView!
    @IBOutlet private var likeControlView: LikeControl!

    // MARK: Public Methods

    func configure(imageName: String, likesCount: Int) {
        avatarPersonImageView.image = UIImage(named: imageName)
        likeControlView.likeCount = likesCount
    }
}
