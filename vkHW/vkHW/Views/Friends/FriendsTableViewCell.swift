// FriendsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка друга
final class FriendsTableViewCell: UITableViewCell {
    // MARK: - IBOutlets

    @IBOutlet var avatarView: AvatarView!
    @IBOutlet var nameLabel: UILabel!

    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK: - Public Methods

    func configure(nameLabelText: String, avatarImageName: String) {
        nameLabel.text = nameLabelText
        avatarView.image = UIImage(named: avatarImageName)
    }
}
