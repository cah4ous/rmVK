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
        guard let url = URL(string: avatarImageName),
              let data = try? Data(contentsOf: url)
        else { return }

        nameLabel.text = nameLabelText
        avatarView.image = UIImage(data: data)
    }
}
