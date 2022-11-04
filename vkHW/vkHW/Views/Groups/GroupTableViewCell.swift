// GroupTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка группы
final class GroupTableViewCell: UITableViewCell {
    // MARK: - IBOutlets

    @IBOutlet private var groupImageView: UIImageView!
    @IBOutlet private var groupNameLabel: UILabel!

    // MARK: - Public Methods

    func configure(nameLabelText: String, groupsImageName: String) {
        groupNameLabel.text = nameLabelText
        groupImageView.image = UIImage(named: groupsImageName)
    }
}
