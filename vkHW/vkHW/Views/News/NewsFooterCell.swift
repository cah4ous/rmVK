// NewsFooterCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка реакций пользователей на новость
final class NewsFooterCell: UITableViewCell, NewsCellConfigurable {
    // MARK: - Private IBOutlets

    @IBOutlet private var likeControl: LikeControl!
    @IBOutlet private var likesCountLabel: UILabel!

    // MARK: - Public Methods

    func configure(_ news: NewsFeed, photoCacheService: PhotoCacheService) {
        likesCountLabel.text = "\(news.likes.count)"
    }
}
