// GroupTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка группы
final class GroupTableViewCell: UITableViewCell {
    // MARK: - Private IBOutlets

    @IBOutlet private var groupImageView: UIImageView!
    @IBOutlet private var groupNameLabel: UILabel!

    // MARK: - Public Methods

    func configure(nameLabelText: String, url: String, photoCacheService: PhotoCacheService?) {
        groupNameLabel.text = nameLabelText
        groupImageView.image = photoCacheService?.photo(byUrl: url)
    }
}
