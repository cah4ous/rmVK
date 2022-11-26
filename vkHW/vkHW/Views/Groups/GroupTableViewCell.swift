// GroupTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка группы
final class GroupTableViewCell: UITableViewCell {
    // MARK: - Private IBOutlets

    @IBOutlet private var groupImageView: UIImageView!
    @IBOutlet private var groupNameLabel: UILabel!

    // MARK: - Public Methods

    func configure(nameLabelText: String, groupsImageName: String) {
        guard let url = URL(string: groupsImageName),
              let data = try? Data(contentsOf: url)
        else { return }
        groupNameLabel.text = nameLabelText
        groupImageView.image = UIImage(data: data)
    }
}
