// GroupTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка группы
final class GroupTableViewCell: UITableViewCell {
    // MARK: - IBOutlets

    @IBOutlet var groupImageView: UIImageView!
    @IBOutlet var groupNameLabel: UILabel!

    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK: - Public Methods

    func configure(nameLabelText: String, groupsImageName: String) {
        groupNameLabel.text = nameLabelText
        groupImageView.image = UIImage(named: groupsImageName)
    }
}
