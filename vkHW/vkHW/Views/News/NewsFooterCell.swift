// NewsFooterCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Футер ячейки
final class NewsFooterCell: UITableViewCell {
    // MARK: - IBOutlets

    @IBOutlet private var likeControl: LikeControl!

    @IBOutlet private var likesCountLabel: UILabel!
    @IBOutlet private var viewLabel: UILabel!

    // MARK: - Public Methods

    func configure(_ news: NewsFeed) {
        likesCountLabel.text = "\(news.likes.count)"
    }
}
