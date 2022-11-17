// FriendsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка друга
final class FriendsTableViewCell: UITableViewCell {
    // MARK: - Private IBOutlets

    @IBOutlet private var avatarView: AvatarView!
    @IBOutlet private var nameLabel: UILabel!

    // MARK: - Public Methods

    func configure(nameLabelText: String, avatarImageName: String) {
        nameLabel.text = nameLabelText
        avatarView.image = UIImage(named: avatarImageName)
    }
}
