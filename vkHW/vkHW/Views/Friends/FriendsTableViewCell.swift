// FriendsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка друга
final class FriendsTableViewCell: UITableViewCell {
    // MARK: - Private IBOutlets

    @IBOutlet private var avatarImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!

    // MARK: - Public Methods

    func configure(nameLabelText: String, avatarImage: UIImage?) {
        nameLabel.text = nameLabelText
        avatarImageView.image = avatarImage
    }
}
